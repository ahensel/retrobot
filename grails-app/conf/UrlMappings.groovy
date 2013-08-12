class UrlMappings {

	static mappings = {
		"/$controller/$action?/$id?"{
			constraints {
				// apply constraints here
			}
		}

        "/retro"(controller:"retrospective", action:"show")

        "/"(controller:"project", action:"show")

		"500"(view:'/error')
	}
}
