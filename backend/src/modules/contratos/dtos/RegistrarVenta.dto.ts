import { ApiProperty } from '@nestjs/swagger';
import {
  IsDate,
  IsNotEmpty,
  IsNumber,
  IsOptional,
  IsString,
  MaxLength,
  Min,
  MinLength,
} from 'class-validator';

export interface RegistrarVenta {
  fecha: Date;
  propiedadId: string;
  precioVenta: number;
  propietarioNuevoId: string;
  empleadoVendedorId: string;
}

export class RegistrarVentaDTO implements RegistrarVenta {
  @ApiProperty({
    description: 'Fecha de la venta',
    example: '2021-09-30',
    required: true,
    nullable: false,
  })
  @IsDate()
  @IsNotEmpty()
  fecha: Date;

  //--------------------------------------------------------------------------------
  @ApiProperty({
    description: 'Id de la propiedad vendida',
    example: 'PR4a2bb647',
    required: true,
    nullable: false,
  })
  @IsString()
  @MinLength(10)
  @MaxLength(10)
  @IsNotEmpty()
  propiedadId: string;

  //--------------------------------------------------------------------------------
  @ApiProperty({
    description: 'Precio de la venta',
    example: 305120.75,
    required: true,
    nullable: false,
  })
  @IsNumber()
  @IsNotEmpty()
  precioVenta: number;

  //--------------------------------------------------------------------------------
  @ApiProperty({
    description: 'Id del nuevo propietario',
    example: 'CLfdb159b2',
    required: true,
    nullable: false,
  })
  @IsString()
  @MinLength(10)
  @MaxLength(10)
  @IsNotEmpty()
  propietarioNuevoId: string;

  //--------------------------------------------------------------------------------
  @ApiProperty({
    description: 'Id del empleado que realizó la venta',
    example: 'EM98101cef',
    required: true,
    nullable: false,
  })
  @IsString()
  @MinLength(10)
  @MaxLength(10)
  @IsNotEmpty()
  empleadoVendedorId: string;
}
