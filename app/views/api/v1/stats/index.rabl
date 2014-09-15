# Most searched tags (for Cloud)
node :tags do |u|
  @tags.map do |t|
    {text: t[0], weight: t[1], link: "http://biodiversity.europa.eu/search?q=#{t[0]}"}
  end
end

# Last added Documents, Webpages and Links
node :last do |u|
  @last.map do |t|
    { type: t.class, title: t.title, link: t.source_url,
      published_on: "Published on #{t.published_on}" }
  end
end

# Content count
node :counts do
  @counts
end
