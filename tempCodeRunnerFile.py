        sql = generateStatementViewer('Criminals', 'select', query, table)
        permission = session.get("permission")
        df = runstatement(sql)