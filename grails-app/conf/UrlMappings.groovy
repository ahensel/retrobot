class UrlMappings {

	static mappings = {
		"/$controller/$action?/$id?"{
			constraints {
				// apply constraints here
			}
		}

        "/retro"(controller:"retrospective", action:"show")

        "/projects"(controller:"project", action:"show")

        "/"(controller:"login", action:"show")

		"500"(view:'/error')
	}
}
