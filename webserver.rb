require 'socket'
require 'cgi'

webserver = TCPServer.new('127.0.0.1', ARGV[0])

info=File.open("/data/info.txt", 'r').read()

form="""
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
""".sub! "INFOLOCATION" info



while (session = webserver.accept)
   session.print "HTTP/1.1 200/OK\r\nContent-type:text/html\r\n\r\n"
   request = session.gets
   trimmedrequest = CGI.unescape(request.gsub(/GET\ \//, '').gsub(/\ HTTP.*/, ''))
   if ( trimmedrequest.downcase =~ /action(.*)url(.*)http(.*)/ )
      print trimmedrequest
      pid = spawn("./wait_pwd.sh");
      Process.detach(pid)
   end
   filename = "form.html"
   begin
      displayfile = File.open(filename, 'r')
      content = displayfile.read()
      session.print content
   rescue Errno::ENOENT
      session.print "File not found"
   end
   session.close
end
