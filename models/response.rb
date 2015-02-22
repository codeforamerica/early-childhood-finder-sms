class Response

  def parse_address(address)
    lat_long = Geocoder.search(address)[0].data["geometry"]["location"]
    if lat_long.present?
      [lat_long["lat"], lat_long["lng"]]
    end
  end

  def address_results(raw_input)
    address_with_somerville = raw_input + ", Somerville, MA"
    lat_long = parse_address(address_with_somerville)
    if lat_long.present?
      nearest_centers = CareCenter.nearest_centers(lat_long)
      if nearest_centers.present?
        return {
          "list" => list_results(nearest_centers),
          "details" => detail_results(nearest_centers)
        }       
      end
    end
  end

  def list_results(centers)
    results_string = "Thanks. Reply with program number for more info. "
    n = 1
    centers.each do |r|
      results_string += "(#{n}) #{r.name}. "
      n += 1
    end
    return results_string
  end

  def detail_results(centers)
    results_hash = {}
    n = 1
    centers.each do |c|
      results_hash[n] = "#{c.name} #{c.phone} #{c.address} #{c.email}"
    end
    return results_hash
  end

  def send_text(to_phone, body)
    $twilio_client.messages.create(
      from: ENV["TWILIO_PHONE"],
      to: to_phone,
      body: body
    )
  end

end