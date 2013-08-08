package bm
import jxl.Workbook
import grails.plugin.jxl.builder.ExcelBuilder
import com.baoming.Province
import com.baoming.District
import com.baoming.MiddleSchool
import com.baoming.account.Teacher
import com.baoming.account.TeacherDistrict
import com.baoming.account.Role
import com.baoming.account.UserRole
import com.baoming.City

class DownloadService {

    def getExcels(def file,def citys)  throws Exception{
        def cityIds = citys.collect{cc->
            return cc.number?:cc.code
        }
        def book=Workbook.getWorkbook(file);//
        def sheet=book.getSheet(0);   //获得第一个工作表对象
        def titles = []
        def recs = []
        for(int i=0;i<sheet.getRows();i++){
            def map = [:]
            breakA:
            for(int j=0;j<sheet.getColumns();j++){
                def cell=sheet.getCell(j, i);  //获得单元格
                def content = cell.contents
                content = content?content.trim():''
                if(i == 0){
                    titles << content
                }else{
                    if (j == 0 && cityIds.count(content) == 0 ){
                        break breakA
                    }
                    map["${titles[j]}"] =content
                }

            }
            if(map){
                recs << map
            }
        }
        return recs
    }

    def build(def list,def outputStream) throws Exception {
        new ExcelBuilder().workbook(outputStream) {

            sheet { //Default name for sheet
                list.eachWithIndex {m,i->
                    def index = 0
                    if(i ==0 ){
                        m.each {k,v->
                            cell(index,0,k)
                            cell(index,1,v)
                            index++
                        }
                    }else{
                        m.each {k,v->
                            cell(index,i+1,v)
                            index++
                        }
                    }
                }
            }
        }
    }

    /**
     * 将一个excel文件读取，并返回一个列表
     * 列表每一列是一个列表，对应excel的列。
     *
     * @param fileInputStream
     * @return   [[a,b,c],...]
     */
    def getExcelToList(def fileInputStream) {
        def book=Workbook.getWorkbook(fileInputStream);//
        def sheet=book.getSheet(0);   //获得第一个工作表对象
        def list = []
        for(int i=1;i<sheet.getRows();i++){
            def cols = []
            for(int j=0;j<sheet.getColumns();j++){
                def cell=sheet.getCell(j, i);  //获得单元格
                def content = cell.contents
                cols << content
            }
            list << cols
        }
        return list
    }

    def saveMiddleSchoolFromList(def list) {
        def succ = 0
        def fail = 0
        list.each{l->
            def len = l.size()
            def district = District.findByNumber(l[2])
            district = district?:District.findByCode(l[2])
            if(!district) {
                fail++
                 return
            }
            try {
                def name = l[3]
                def code = l[4]
                def contact = l[5]
                def tel = l[6]
                def desc = l[7]
                def middleSchool = new MiddleSchool([district:district,name:name,code:code])
                middleSchool.contact = contact
                middleSchool.tel = tel
                middleSchool.description = desc
                if(!middleSchool.save()){
                    fail++
                    return
                }
                succ++

            } catch (Exception e) {
                fail++
                return
            }
        }
        [succ:succ,fail:fail]
    }

    def saveTeacherFromList(def list) {
        def succ = 0
        def fail = 0
        list.each{l->

            try {
                def len = l.size()
                def name = l[0]
                def username = l[1]
                def pwd = l[2]
                def districts
                if(len > 3) {
                    districts = l[3].tokenize(',')
                }
                def status = true
                if (len > 4) {
                     status = l[4]
                }

                def teacher = new Teacher([enabled:status,name:name,username:username,password:pwd])
                if(!teacher.save()){
                    log.error(teacher.errors)
                    fail++
                    return
                }
                def role = Role.findByAuthority(Role.AUTHORITY_TEACHER)
                def ur = UserRole.create(teacher, role, true)
                if (!ur) {
                    fail++
                    return
                }

                districts?.each{d->
                   def dd = District.findByNumber(d)
                    dd = dd?:District.findByCode(d)
                    def tc  = new TeacherDistrict()
                    if(!tc) {
                        return
                    }
                    tc.district = dd
                    tc.teacher = teacher
                    tc.save()
                }
                succ++

            } catch (Exception e) {
                return
            }
        }
        [succ:succ,fail:fail]
    }
}
