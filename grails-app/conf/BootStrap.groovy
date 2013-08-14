import retrobot.Project

class BootStrap {

    def init = { servletContext ->

        if (!Project.count()) {
            new Project(name: "Crazy Train").save(failOnError: true)
            new Project(name: "Retrospectaculous").save(failOnError: true)
        }
    }
    def destroy = {
    }
}
