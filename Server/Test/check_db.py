import sqlalchemy

conn = sqlalchemy.create_engine('sqlite:///./sql_app.db')
cursor = conn.connect()
resultados = cursor.execute("SELECT * FROM entradas where userID==2")

for fila in resultados:
    print(fila)

print(resultados)