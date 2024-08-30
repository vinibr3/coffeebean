require 'net/http'

module ApplicationHelper
  def active_record_errors(record, attribute)
    content_tag :span, record.errors[attribute.to_sym].join(', '), class: 'text-danger'
  end

  def ipinfo(ip)
    url = URI.parse("http://ipinfo.io/#{ip}?token=1ff5903f019aed")
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }

    JSON.parse(res.body)
  rescue StandardError
    {}
  end
end
