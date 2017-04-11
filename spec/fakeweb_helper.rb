def fake(link, with:, as: 'text/html')
  FakeWeb.register_uri(:get, link, content_type: as, body: with)
end
