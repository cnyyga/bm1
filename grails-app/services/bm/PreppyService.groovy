package bm

import com.baoming.ProtocolCode
import groovy.transform.Synchronized

class PreppyService {

    @Synchronized
    def buildProtocolCode() {
        def cal = Calendar.instance
        def year = cal.get(Calendar.YEAR)
        def pc = ProtocolCode.createCriteria().get {

            eq('year', year)
            projections {
                max('num')
            }
        }

        if(!pc)   {
            pc = 0
        }
        pc = pc + 1
        new ProtocolCode(year:year,num: pc).save(flush: true)

        return "${year}${cover(pc)}"
    }

    def cover (def num) {
         if(!num) {
             return "0001";
         }
        num = num as String
        def len = num.length();
        (0..(3-len)).each {
            num = "0${num}"
        }
        return num
    }
}
