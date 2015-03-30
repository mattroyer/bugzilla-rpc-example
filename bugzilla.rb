require 'open-uri'
require 'json'

class Bugzilla
  attr_accessor :response

  def initialize number
    @number = number
    @username = '<username>'
    @password = '<password>'
    @bug_url = "http://bugs.mainman.dcs/bugzilla/show_bug.cgi?id=#{@number}"
  end

  def get_bug method
    options = {
      method: "Bug.#{method}",
      params: %W([{"Bugzilla_login":"#{@username}","Bugzilla_password":"#{@password}","ids":["#{@number}"]}])
    }

    params = URI.encode_www_form(options)

    page = open("http://bugs.mainman.dcs/bugzilla/jsonrpc.cgi?#{params}").read

    @response = JSON.parse page
  end

  def info
    get_bug 'get'

    "Priority: #{@response['result']['bugs'][0]['priority']}\nSummary: #{@response['result']['bugs'][0]['summary']}\nLink: #{@bug_url}"
  end

  def comments
    get_bug 'comments'

    @response['result']['bugs'][@number]['comments'].map { |comment| "Author: #{comment['author']}\n\nComment: #{comment['text']}\n\n" }
  end

end
