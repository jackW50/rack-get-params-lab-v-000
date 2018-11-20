class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/add/)
      search_term = req.params["q"]
      add_to_cart(search_term)
    elsif req.path.match(/cart/)
      @@cart.each do |item|
        resp.write "#{item}"
      end 
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
  
  def item_unique?(search_term)
    @@cart.include?(search_term)
  end 
  
  def add_to_cart(search_term) 
    if item_unique?
      @@cart << search_term
    else 
      resp.write "#{search_term} already present in cart."
  end 
end
