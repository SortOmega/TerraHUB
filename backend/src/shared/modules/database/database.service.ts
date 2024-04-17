import { Injectable } from '@nestjs/common';
import { Pool, QueryResult } from 'pg';
import { dbConfig } from 'src/config/config';

@Injectable()
export class DatabaseService {
  //variable para la conexion a la base de datos
  public pg: Pool;
  public pgLarge: Pool;

  private defaultPgFuncOptions: DBFuncOptions = {
    isLargeResponseTime: false,
  };

  constructor() {
    // Parametros para la conexión larga.
    const maximoMinutos = 360;
    const maximoMilisegundos = maximoMinutos * (60 * 1000);

    //inicializar la conexion a la base de datos
    this.pg = new Pool(dbConfig());
    this.pgLarge = new Pool({
      ...dbConfig(),
      keepAlive: true,
      idleTimeoutMillis: 1200000, // 20 minutos
      connectionTimeoutMillis: maximoMilisegundos,
      query_timeout: maximoMilisegundos,
      statement_timeout: maximoMilisegundos,
    });
  }

  //Metodo para ejecutar una consulta a la base de datos
  async pgFunc<Response = unknown>(
    funcion: string,
    argumentos: unknown[] = [],
    funcOptions: DBFuncOptions = this.defaultPgFuncOptions
  ) {
    try {
      //Separrar el nombre de la funcion del esquema
      const keyFun: string = funcion.split('.')[1].toString();

      //construir la cadena de argumentos para la funcion
      const stringArgumentosFuncion = argumentos.map((_, index) => '$' + (index + 1)).join();

      //construir la cadena de la funcion con sus argumentos
      const stringFuncion = `SELECT * FROM ${funcion}(${stringArgumentosFuncion})`;

      //ejecutar la funcion

      let dbFunctionResponse = !funcOptions.isLargeResponseTime
        ? await this.pg.query<Response>(stringFuncion, argumentos)
        : await this.pgLarge.query<Response>(stringFuncion, argumentos);

      //retornar el resultado de la funcion
      return dbFunctionResponse.rows[0][`${keyFun}`];
    } catch (error) {
      console.log(error);
      throw new Error(error.message);
    }
  }
}

interface DBFuncOptions {
  isLargeResponseTime: boolean;
}
