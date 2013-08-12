package retrobot

class ProjectController {

    def index() { }

    def show() {
        // should only show the user's projects
        [projects: Project.findAll()]
    }
}
