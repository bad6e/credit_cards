module UserAgent

  class OpenFile
    def open_file
      file_information = File.open("lib/assets/useragents-no-mobile.txt", "r").map do |line|
        data = line.split(/\t/)
      end
    end
  end
end
