package retrobot

import grails.converters.JSON
import sun.misc.BASE64Encoder

class LoginController {

    def show() {
        render template:"show"
    }

    def login() {
        def username = params.username
        def password = params.password

        if (authenticate(username, password)) {
            redirect controller: 'project', action: 'show'
        }
        else {
            redirect controller: 'login', action: 'show'
        }
    }

    def authenticate(username, password) {
        // TEMPORARY override until I figure out what is wrong with the WSAPI call
        if (username.startsWith("ahensel")) {
            return true
        }

        // this doesn't actually work :-(
        try {
            def securityToken = getSecurityToken(username, password)
            return true
        }
        catch (IOException ioe) {
            return false
        }
    }


    def getSecurityToken(username, password) {
        URL url = new URL("https://test3cluster.rallydev.com/slm/webservice/v2.x/security/authorize")
        HttpURLConnection connection = (HttpURLConnection) url.openConnection()
        connection.setRequestMethod("GET")

        def encoder = new BASE64Encoder()
        String encodedCredential = encoder.encode((username + ":" + password).getBytes())
        connection.setRequestProperty("Authorization", "Basic " + encodedCredential)
        connection.connect()

        InputStream responseBodyStream = connection.getInputStream()
        byte[] buffer = new byte[8192]
        int read = 0
        StringBuffer responseBody = new StringBuffer()
        while ((read = responseBodyStream.read(buffer)) != -1) {
            responseBody.append(new String(buffer, 0, read))
        }
        connection.disconnect()

        def response = responseBody.toString()
        def parsedResponse = JSON.parse(response)
        return parsedResponse["OperationResult"]["SecurityToken"]
    }
}
