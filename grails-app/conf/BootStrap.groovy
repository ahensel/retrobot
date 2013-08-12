import retrobot.Project

class BootStrap {

    def init = { servletContext ->

        if (!Project.count()) {
            new Project(name: "Project Alpha").save(failOnError: true)
            new Project(name: "Project Beta").save(failOnError: true)
        }
    }
    def destroy = {
    }
}
