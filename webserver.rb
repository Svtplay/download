require 'socket'
require 'uri'

webserver = TCPServer.new('0.0.0.0', ARGV[0])

info=File.open("../data/info.txt", 'r').read()

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
   request = URI.unescape(session.gets)
   print request
   if ( request.include?('action') && request.include?('url=') )
      url2 = request.split("=")[1]
      url1 = url2.split(" ")[0]
          if (request.include?('?'))
                url = url1.split("?")[0]
          else
                url = url1
          end
      print url
      pid = spawn("../data/download_start.sh " + url);
      Process.detach(pid)
   end
   begin
      session.print form
   rescue Errno::ENOENT
      session.print "File not found"
   end
   session.close
end

