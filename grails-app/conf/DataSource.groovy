dataSource {
    pooled = true
}
hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = true
    cache.region.factory_class = 'net.sf.ehcache.hibernate.EhCacheRegionFactory'
}
environments {
    development {
        dataSource {

//            dbCreate = "create-drop"
//            dbCreate = "update"
//            url = "jdbc:h2:mem:testDb;MVCC=TRUE;LOCK_TIMEOUT=10000"
            dbCreate = "update"
            pooled = true
            driverClassName = "com.mysql.jdbc.Driver"
            url = "jdbc:mysql://localhost:3306/bm?useUnicode=true&amp;characterEncoding=utf-8"
            username = "root"
            password = "1"
            logSql = 'true'
        }
    }
    test {
        dataSource {
            dbCreate = "update"
            url = "jdbc:h2:mem:testDb;MVCC=TRUE;LOCK_TIMEOUT=10000"
        }
    }
    production {
        dataSource {
            dbCreate = "update"
            jndiName = "java:comp/env/jdbc/bmDB"
        }
    }
}
