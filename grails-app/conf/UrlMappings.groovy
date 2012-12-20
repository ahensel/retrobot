class UrlMappings {

	static mappings = {
		"/$controller/$action?/$id?"{
			constraints {
				// apply constraints here
			}
		}

<<<<<<< HEAD
		"/"(controller:"retrospective", action:"show")
=======
//        "/$id?"(controller:"retrospective", action:"show")
        "/"(controller:"retrospective", action:"show")
>>>>>>> 134d7ddbefb28bc1e9391dd15821523706f22df8
		"500"(view:'/error')
	}
}
