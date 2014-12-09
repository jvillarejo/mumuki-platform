require 'tempfile'

class Tempfile
  def self.for_content(name, content)
    file = Tempfile.new(name)
    begin
      file.write(content)
      file
    ensure
      file.close
    end
  end
end