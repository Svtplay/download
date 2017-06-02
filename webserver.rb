require 'socket'
require 'cgi'

webserver = TCPServer.new('0.0.0.0', ARGV[0])

info=File.open("/data/info.txt", 'r').read()

form=<<-FOO
<!DOCTYPE html>
<html>
<body>
<form action="/action" method="get">
  Svtplay URL:<br>
  <input size=120 type="text" name="url" value="https://www.svtplay.se/video/13851672/djursjukhuset/djursjukhuset-sasong-19-avsnitt-8">
  <br>
  <input type="submit" value="Download">
</form>
<br><br>
<pre>
INFOLOCATION
</pre>
</body>
</html>
FOO

form=form.sub('INFOLOCATION',info)

while (session = webserver.accept)
   session.print "HTTP/1.1 200/OK\r\nContent-type:text/html\r\n\r\n"
   request = session.gets
   trimmedrequest = CGI.unescape(request.gsub(/GET\ \//, '').gsub(/\ HTTP.*/, ''))
   if ( trimmedrequest.downcase =~ /action(.*)url(.*)http(.*)/  && trimmedrequest.split("=").length==2)
      url = trimmedrequest.split("=")[1]
      print url
      pid = spawn("/data/download_start.sh " + url);
      Process.detach(pid)
   end
   begin
      session.print form
   rescue Errno::ENOENT
      session.print "File not found"
   end
   session.close
end
