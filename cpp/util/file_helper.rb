# frozen_string_literal: true

require "colorize"
require "fileutils"
require "logger"

module Emerald
  module FileHelper
    attr_accessor :logger
    def initialize
      @logger = ::Logger.new(STDOUT)
    end

    def create_file(file_name, file_contents)
      logger.info "[Info] Writing header file #{file_name}..."

      File.open(file_name, "w") { |file| file.write file_contents }

      logger.info "[Create] Wrote header file #{file_name}.".colorize(:green)
    end

    def update_file(file_path, text_to_insert, line_to_insert_before)
      logger.info "[Info] Updating grammar file #{file_path}..."

      modified_contents = File.readlines(file_path).map do |line|
        line.strip == line_to_insert_before ? text_to_insert + line : line
      end

      File.open(file_path, "w") { |file| file.write modified_contents.join }

      logger.info "[Update] Updated grammar file #{file_path}.".colorize(:green)
    end
  end
end
