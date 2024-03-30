import { InternalServerErrorException } from '@nestjs/common';
import _ from 'lodash';
import { PoolConfig } from 'pg';

const port = Number(process.env.DB_PORT);
if (_.isNaN(port))
  throw new InternalServerErrorException(
    'Se ha pasado un puerto No Valido en la configuracion del API'
  );

export const dbConfig: PoolConfig = {
  host: process.env.DB_HOST,
  port: Number(process.env.DB_PORT),
  database: process.env.DB_NAME,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
};
