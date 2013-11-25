class UrlMappings {

	static mappings = {
		"/$controller/$action?/$id?"{
			constraints {
				// apply constraints here
			}
		}

		//"/"(view:"/index")
        "/"(controller: 'reg')
		"500"(view:'/error')
        "404"(view:'/error')
	}
}
