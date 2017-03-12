module NginxHelper

  def server_name
    if subdomains = fetch(:subdomains)
      subdomains = "(?<subdomains>(" + subdomains.join("|") + ")\\.)?"
    end
    "~^(www\\.)?#{subdomains}#{url}$"
  end

  def return_url
    "https://${subdomains}#{url}${request_uri}"
  end

  def ssl?
    fetch(:ssl, false)
  end

  def url
    fetch(:url, "localhost")
  end

  def default_server
    "default_server" unless fetch(:side_app, false)
  end

  def erb_eval(path)
    StringIO.new(ERB.new(File.read(path), nil, '-').result(binding))
  end

end
