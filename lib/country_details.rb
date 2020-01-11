require 'rest-client'

module CountryDetails

  class Get
    @@all_countries = []
    def initialize
      url = 'https://restcountries.eu/rest/v2/all'
      rest_client_response = RestClient.get(url)
      @@all_countries = JSON.parse(rest_client_response.body)
    end

    def all
      @@all_countries
    end

    def details_by_name(country_name, options = {})
      detail = @@all_countries.map{|detail| detail if detail["name"]==country_name.capitalize}.compact
      return {'success': 'false', 'Error': 'Invalid country name!'} unless detail.present?
      return detail
    end
   
    def details_by_code(code, options = {})
      code = code.upcase
      if code.length == 2
        detail = @@all_countries.map{|detail| detail if detail["alpha2Code"]==code}.compact
      elsif code.length == 3
        detail = all.map{|detail| detail if detail["alpha3Code"]==code}.compact 
      end      
      return {'success': 'false', 'Error': 'Invalid code!'} unless detail.present? 
      return detail
    end

  end
end