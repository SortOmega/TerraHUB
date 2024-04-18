import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsOptional, IsString, MaxLength, MinLength } from 'class-validator';

export interface RegistrarCliente {
  nombre: string;
  apellido: string;
  identidad: string;
  email: string;
  telefono: string;
  tipoClienteId: string;
}

export class RegistrarClienteDTO implements RegistrarCliente {
  @ApiProperty({
    description: 'Nombre del cliente',
    example: 'Esteban',
    required: true,
    nullable: false,
  })
  @IsString()
  @IsNotEmpty()
  nombre: string;

  //----------------------------------------------
  @ApiProperty({
    description: 'Nombre del cliente',
    example: 'Quito',
    required: true,
    nullable: false,
  })
  @IsString()
  @IsNotEmpty()
  apellido: string;
  //----------------------------------------------
  @ApiProperty({
    description: 'Identidad o DNI del cliente',
    example: '0105-1999-00000',
    required: true,
    nullable: false,
  })
  @IsString()
  identidad: string;

  //----------------------------------------------
  @ApiProperty({
    description: 'Email del Cliente',
    example: 'my.custom.email987@gmail.com',
    required: false,
    nullable: true,
  })
  @IsString()
  @IsOptional()
  email: string;

  //----------------------------------------------
  @ApiProperty({
    description: 'Teléfono del cliente',
    example: '+504 9876-5432',
    required: false,
    nullable: true,
  })
  @IsString()
  @IsOptional()
  telefono: string;

  //----------------------------------------------
  @ApiProperty({
    description: 'Id del tipo de cliente',
    example: 'TC-VEND',
    required: true,
    nullable: false,
  })
  @IsString()
  @MinLength(10)
  @MaxLength(10)
  @IsNotEmpty()
  tipoClienteId: string;
}
