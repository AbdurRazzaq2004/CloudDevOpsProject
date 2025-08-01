def call(String image, String contextDir) {
    dir(contextDir) {
        sh "docker build -t ${image} ."
    }
}
