package com.baoming

import org.springframework.dao.DataIntegrityViolationException

class WelcomeController {


    def index() {
        redirect(action: "create", params: params)
    }

    def create() {
        def welcome = Welcome.list()
        [welcomeInstance: welcome?welcome[0]:null]
    }

    def save() {
        def welcomeInstance = Welcome.list()
        if(!welcomeInstance || welcomeInstance.empty) {
            welcomeInstance = new Welcome()
        }else{
            welcomeInstance = welcomeInstance[0]
        }
        welcomeInstance.properties = params
        if (!welcomeInstance.save(flush: true)) {
            render(view: "create", model: [welcomeInstance: welcomeInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'welcome.label', default: 'Welcome'), welcomeInstance.id])
        redirect(action: "create")
    }

}
