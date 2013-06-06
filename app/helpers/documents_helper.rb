module DocumentsHelper


    # COUNTRIES

    def merge_country(params, facet_term)
        countries = Array.new

        if params[:countries].present?


            _countries_string = params[:countries]
            _countries_array = _countries_string.split(/\//)

            for c in _countries_array
                countries << c
            end

            params = params.except(:countries)

            # countries.concat('-').concat(facet_term)
            countries << facet_term
            # countries << 'Spain'
        else
            countries << facet_term
            # countries << 'Spain'
        end

        # hash.inject({}) {|r,a| r.merge(a.first=>a.last.first)}
        url = params.merge(:countries => countries.to_param, :page => 1)
    end

    def remove_country(params, facet_term)
        countries = Array.new
        _countries_string = params[:countries]
        _countries_array = _countries_string.split(/\//)

        for c in _countries_array
            countries << c unless c == facet_term
        end
        url = params.merge(:countries => countries.to_param, :page => 1)
    end

    # LANGUAGES

    def merge_language(params, facet_term)
        langs = Array.new

        if params[:languages].present?


            _langs_string = params[:languages]
            _langs_array = _langs_string.split(/\//)

            for c in _langs_array
                langs << c
            end

            params = params.except(:languages)
            langs << facet_term
        else
            langs << facet_term
        end

        params.merge(:languages => langs.to_param, :page => 1)
    end

    def remove_language(params, facet_term)
        langs = Array.new
        _langs_string = params[:languages]
        _langs_array = _langs_string.split(/\//)

        for c in _langs_array
            langs << c unless c == facet_term
        end
        url = params.merge(:languages => langs.to_param, :page => 1)
    end

end
