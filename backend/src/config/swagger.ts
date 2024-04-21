import { DocumentBuilder, SwaggerCustomOptions } from '@nestjs/swagger';

export const swaggerConfig = new DocumentBuilder()
  .setTitle('TerraHub API - Inmobiliaria')
  .setDescription(
    'API de TerraHub para la administración de propiedades inmobiliarias, clientes y contratos.'
  )
  .setVersion('1')
  //LISTADO DE TAGS-------------------------------------------------------------
  .addTag('API Inicial', 'Endpoints de prueba TerraHub.')
  .addTag(
    'Mantenimiento de Propiedades',
    'Endpoints para el mantenimiento de las propiedades inmobiliarias.'
  )
  .addTag('Mantenimiento de Clientes', 'Endpoints para el mantenimiento de los clientes.')
  .addTag('Mantenimiento de Contratos', 'Endpoints para el mantenimiento de los contratos.')
  .addTag(
    'Mantenimiento de Planilla',
    'Endpoints para el mantenimiento de la planilla y empleados del organigrama.'
  )
  .addBearerAuth()
  //FINALIZA CONFIGURACION------------------------------------------------------
  .build();

export const swaggerCustomOptions: SwaggerCustomOptions = {
  swaggerOptions: {
    docExpansion: 'none', // Esto colapsará los tags por defecto
  },
};
