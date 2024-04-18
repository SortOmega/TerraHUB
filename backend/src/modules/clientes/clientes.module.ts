import { ClientesController } from './clientes.controller';
import { ClientesService } from './clientes.service';
import { Module } from '@nestjs/common';

@Module({
  imports: [],
  controllers: [ClientesController],
  providers: [ClientesService],
  exports: [],
})
export class ClientesModule {}
