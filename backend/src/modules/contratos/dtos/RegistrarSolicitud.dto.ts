import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsOptional, IsString, MaxLength, MinLength } from 'class-validator';

export interface RegistrarSolicitud {
  nombre: string;
  apellido: string;
  identidad: string;
  email: string;
  telefono: string;
  descripcionSolicitud: string;
  tipoSolicitudId: string;
}

export class RegistrarSolicitudDTO implements RegistrarSolicitud {
  @ApiProperty({
    description: 'Nombre del cliente de la Solicitud',
    example: 'Esteban',
    required: true,
    nullable: false,
  })
  @IsString()
  @IsNotEmpty()
  nombre: string;

  //----------------------------------------------
  @ApiProperty({
    description: 'Apellido del cliente de la Solicitud',
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
    description: 'Descripción de la Solicitud',
    example: 'Solicitud de compra de inmueble',
    required: true,
    nullable: false,
  })
  @IsString()
  @MaxLength(255)
  @IsNotEmpty()
  descripcionSolicitud: string;

  //----------------------------------------------
  @ApiProperty({
    description: 'Id del tipo de solicitud',
    example: 'TCON-COMP',
    required: true,
    nullable: false,
  })
  @IsString()
  @IsNotEmpty()
  tipoSolicitudId: string;
}
