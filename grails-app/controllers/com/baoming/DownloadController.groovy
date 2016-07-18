package com.baoming

import org.apache.commons.io.FileUtils
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils
import com.baoming.account.Role
import com.baoming.account.Teacher
import org.apache.commons.io.IOUtils
import grails.plugin.jxl.builder.ExcelBuilder

class DownloadController {

    def springSecurityService
    def downloadService

    def static a = ['.xls','.xlsx']

    def index() {
        [download:Download.find {}]
    }

    def upload(){
        def file = request.getFile("file")
        if (file && !file.empty) {
            def fileName = file.originalFilename
            def suffix = fileName.substring(fileName.lastIndexOf('.'))
            suffix = suffix.toLowerCase()
            if(a.count(suffix) == 0)   {
                flash.message = message(code: 'download.alert.label')
                redirect(action: 'index')
                return
            }
            def storeName = "student${suffix}"
            def storageFilePath = "${grailsApplication.config.baoming.image.storage.path}" + '/'  + storeName
            def f = new File(storageFilePath)
            //FileUtils.forceMkdir(f)
            file.transferTo(f)
            def download = Download.find {}
            if(!download) {
                download = new Download([name:storeName,date:new Date()])
                download.save()
            }else{
                download.date = new Date()
                download.name = storeName
                download.save()
                DownloadRecord.executeUpdate("delete from DownloadRecord")
            }
        }else{
            flash.message = message(code: 'download.alert.label')
            redirect(action: 'index')
            return
        }
        flash.message = message(code: 'download.success.label')
        redirect(action: 'index')
        return
    }

    def records (Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [downloadRecords: DownloadRecord.list(),total:DownloadRecord.count()]
    }

    def d() {
        def download = Download.find {}
        def storeName = "student.xls"
        def downloadName
        if(download) {
            storeName = download.name
            def suffix = storeName.substring(storeName.lastIndexOf('.'))
            downloadName = new String("${message(code: 'download.file.label')}${suffix}".getBytes('gbk'),"ISO8859_1")
            downloadName = "${downloadName}"
        }else {
            downloadName = new String("${message(code: 'download.file.label')}.xls".getBytes('gbk'),"ISO8859_1")
        }
        def storageFilePath = "${grailsApplication.config.baoming.image.storage.path}" + '/'  + storeName
        def file = new File(storageFilePath)
        if (SpringSecurityUtils.ifAllGranted(Role.AUTHORITY_TEACHER)) {
            def userId = springSecurityService.authentication.principal?.id
            def teacher = Teacher.get(userId)
            if(!teacher){
                log.error("teacher is null,userId:${userId}")
                flash.message = message(code: 'download.city.null.message')
                redirect(action: 'index')
                return;
            }
            def districts
            try {
                def tds = teacher?.teacherDistricts
                districts = tds.findAll {
                    try {
                        it.district
                        return true
                    } catch (e) {
                        return false
                    }
                }

            } catch (e) {
                log.error("districts is null,userId:${userId},error:${e.message}")
                flash.message = message(code: 'download.city.null.message')
                redirect(action: 'index')
                return
            }
            if(!districts || districts.empty) {
                log.error("districts is null,userId:${userId}")
                flash.message = message(code: 'download.city.null.message')
                redirect(action: 'index')
                return
            }
            districts = districts.collect {it.district}

            def outputStream
            try {
                def list = downloadService.getExcels(file,districts)
                if(!list || list.empty) {
                    flash.message = message(code: 'download.null.message')
                    redirect(action: 'index')
                    return
                }
                def dl = Download.find {}
                def dlr = new DownloadRecord([download: dl,teacher:teacher])
                dlr.save()
                outputStream = response.outputStream
                response.setContentType("APPLICATION/OCTET-STREAM");
                response.setHeader("Content-Disposition", "attachment; filename=\""+downloadName+"\"");
                downloadService.build(list,outputStream)
               //
            } catch (Exception e) {
                flash.message = message(code: 'download.null.message')
                redirect(action: 'index')
                return
            } finally {
                IOUtils.closeQuietly(outputStream)
            }

        } else {
            def ins
            def outputStream
            try {
                outputStream = response.outputStream
                ins = new FileInputStream(file)
                response.setContentType("APPLICATION/OCTET-STREAM");
                response.setHeader("Content-Disposition", "attachment; filename=\""+downloadName+"\"");
                IOUtils.copy(ins,outputStream)
            } catch (Exception e) {
                flash.message = message(code: 'download.null.message')
                redirect(action: 'index')
                return
            } finally {
                IOUtils.closeQuietly(ins)
                IOUtils.closeQuietly(outputStream)
            }
        }
        return
    }
}
