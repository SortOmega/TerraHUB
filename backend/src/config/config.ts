import { InternalServerErrorException } from '@nestjs/common';
import * as _ from 'lodash';
import { PoolConfig } from 'pg';

export const dbConfig = () => {
  return {
    host: process.env.DB_HOST,
    port: Number(process.env.DB_PORT) || 3000,
    database: process.env.DB_NAME,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
  } as PoolConfig;
};
