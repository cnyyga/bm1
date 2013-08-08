package com.baoming.account

import org.springframework.dao.DataIntegrityViolationException
import grails.converters.JSON
import com.baoming.City
import com.baoming.Province
import com.baoming.Department

class TeacherController {
    def userService
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        def districtId = params.districtId
        def cityId = params.cityId
        def provinceId = params.provinceId
        def departmentId = params.long('departmentId')
        def name = params.name
        params.max = Math.min(max ?: 10, 100)

        def total = Teacher.createCriteria().count{
            if(name) {
                like('name',"%${name}%")
            }
            if(departmentId) {
                eq('department.id',departmentId)
            }
            if(districtId) {
                teacherDistricts {
                    eq('district.id',districtId)
                }
            }else if(cityId) {
                def city = City.findByCode(cityId)
                if(city) {
                    teacherDistricts {
                        district{
                            eq('city',city)
                        }
                    }
                }
            }else if(provinceId) {
                def province = Province.findByCode(provinceId)
                if(province) {
                    teacherDistricts {
                        district{
                            city{
                                eq('province',province)
                            }
                        }
                    }
                }
            }
        }

        def list = Teacher.createCriteria().list([offset: params.offset,max: params.max]){
            if(name) {
                like('name',"%${name}%")
            }
            if(departmentId) {
                eq('department.id',departmentId)
            }
            if(districtId) {
                teacherDistricts {
                    eq('district.id',districtId)
                }
            }else if(cityId) {
                def city = City.findByCode(cityId)
                if(city) {
                    teacherDistricts {
                        district{
                            eq('city',city)
                        }
                    }
                }
            }else if(provinceId) {
                def province = Province.findByCode(provinceId)
                if(province) {
                    teacherDistricts {
                        district{
                            city{
                                eq('province',province)
                            }
                        }
                    }
                }
            }
        }
        [teacherInstanceList: list, teacherInstanceTotal: total]
    }

    def create() {
        [teacherInstance: new Teacher(params)]
    }

    def save() {
        def teacherInstance = new Teacher(params)
        def cityIds = params.list('cityId')
        def departmentId = params.long('departmentId')
        def department = Department.get(departmentId)
        teacherInstance.department = department
        def a = userService.saveTeacher(teacherInstance,cityIds)
        if (a.status == 0) {
            flash.message = message(code: 'default.save.failure.label')
            render(view: "create", model: [adminInstance: teacherInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'teacher.label', default: 'Teacher'), teacherInstance.id])
        redirect(action: "show", id: teacherInstance.id)
    }

    def show(Long id) {
        def teacherInstance = Teacher.get(id)
        if (!teacherInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'teacher.label', default: 'Teacher'), id])
            redirect(action: "list")
            return
        }

        [teacherInstance: teacherInstance]
    }

    def edit(Long id) {
        def teacherInstance = Teacher.get(id)
        if (!teacherInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'teacher.label', default: 'Teacher'), id])
            redirect(action: "list")
            return
        }

        [teacherInstance: teacherInstance]
    }

    def update(Long id, Long version) {
        def teacherInstance = Teacher.get(id)
        if (!teacherInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'teacher.label', default: 'Teacher'), id])
            redirect(action: "list")
            return
        }
        def cityIds = params.list('cityId')

        teacherInstance.properties = params
        def departmentId = params.long('departmentId')
        def department = Department.get(departmentId)
        teacherInstance.department = department
        def a = userService.updateTeacher(teacherInstance,cityIds)
        if (a.status == 0) {
            flash.message = message(code: 'default.save.failure.label')
            render(view: "edit", model: [teacherInstance: teacherInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'teacher.label', default: 'Teacher'), teacherInstance.id])
        redirect(action: "show", id: teacherInstance.id)
    }

    def delete(Long id) {
        def teacherInstance = Teacher.get(id)
        if (!teacherInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'teacher.label', default: 'Teacher'), id])
            if(params.act) {
                redirect(action: 'list')
                return
            }
            render(([status:0] as JSON) as String )
            return
        }

        try {
            userService.removeUser(teacherInstance)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'teacher.label', default: 'Teacher'), id])
            if(params.act) {
                redirect(action: 'list')
                return
            }
            render(([status:1] as JSON) as String )
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'teacher.label', default: 'Teacher'), id])
            if(params.act) {
                redirect(action: 'list')
                return
            }
            render(([status:0] as JSON) as String )
        }
    }

    def downloadService
    def importFile() {

        if (!params.u) {
            render(view: 'import',model: [status: '0'])
            return
        }
        def file = request.getFile("file")
        if (!file || file.empty) {
            render(view: 'import',model: [status: '2'])
            return
        }

        def list = downloadService.getExcelToList(file.inputStream)
        if(!list) {
            render(view: 'import',model: [status: '2'])
            return
        }
        def r = downloadService.saveTeacherFromList(list)
        render(view: 'import',model: [status: '1']+r)
    }
}
