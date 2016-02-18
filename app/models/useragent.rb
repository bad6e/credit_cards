module UserAgent

  class OpenFile

    def initialize
      @file = open_file
    end
    def open_file
      File.open("lib/assets/useragents-no-mobile.txt", "r").each_line do |line|
      data = line.split(/\t/)
      binding.pry
      # name, job = data.map{|d| d.split(": ")[1] }.flatten
    end

  end

end

