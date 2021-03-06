PUBLIC = "d4445ae4f53b3fbf9ea68b36c00d3dcf"
PRIVATE = "0b48f0bcc0187191ca63625229231eae37a6699f"

def get_timestamp
  Time.now.to_s.split("-").join.split(" ").join.split(":").join
end

def get_hash
  ts = get_timestamp
  string = ts + PRIVATE + PUBLIC
  [ts, Digest::MD5.hexdigest(string)]
end

def get_api_auth
  hash = get_hash
  "?ts=#{hash[0]}&apikey=#{PUBLIC}&hash=#{hash[1]}"
end

def get_api_search(input)
  search = input.split(" ").join("%20")
  "http://gateway.marvel.com:443/v1/public/characters/#{search}"
end

def get_api_URL(input)
  get_api_search(input) + get_api_auth
end
