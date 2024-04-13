import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';

import * as bdParser from 'body-parser';
import { ValidationPipe } from '@nestjs/common';
import { APILogger } from './config/logger';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  app.enableCors({
    allowedHeaders: '*',
    origin: '*',
  });

  app.use(bdParser.json({ limit: '1024mb' }));
  app.use(bdParser.urlencoded({ limit: '1024mb', extended: true }));

  app.useGlobalPipes(new ValidationPipe());

  await app.listen(process.env.API_PORT);

  APILogger.logger.info(
    `[TerraHub API - Inicializando servidor en el puerto ${process.env.API_PORT}]`
  );
}
bootstrap();
