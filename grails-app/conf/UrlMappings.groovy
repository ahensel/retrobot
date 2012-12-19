class UrlMappings {

	static mappings = {
		"/$controller/$action?/$id?"{
			constraints {
				// apply constraints here
			}
		}

//        "/$id?"(controller:"retrospective", action:"show")
        "/"(controller:"retrospective", action:"show")
		"500"(view:'/error')
	}
}
