# encoding: UTF-8

require File.expand_path("../lib/pygmentize", File.dirname(__FILE__))
require "nokogiri"

test "colorizes output" do
  output = Pygmentize.process(%Q[{foo: "bar"}], :javascript)

  doc = Nokogiri::HTML(output)

  assert doc.at_xpath(".//div[@class='highlight']")
  assert doc.at_xpath(".//div[@class='highlight']/pre/span[@class='nx' and text()='foo']")
end

test "handles encodings" do
  output = Pygmentize.process(%Q[{foo: "bar", baz: "qüx"}], :javascript)

  assert output.encoding == Encoding::UTF_8
end
