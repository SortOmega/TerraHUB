import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsOptional, IsString, MaxLength, MinLength } from 'class-validator';
import { RegistrarCliente, RegistrarClienteDTO } from './RegistrarCliente.dto';

export interface ActualizarCliente extends RegistrarCliente {
  clienteId: string;
}

export class ActualizarClienteDTO extends RegistrarClienteDTO implements ActualizarCliente {
  @ApiProperty({
    description: 'Id del Cliente a actualizar',
    example: 'CLe53c0d40',
    required: true,
    nullable: false,
  })
  @IsString()
  @MinLength(10)
  @MaxLength(10)
  @IsNotEmpty()
  clienteId: string;
}
