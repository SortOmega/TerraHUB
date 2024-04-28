import { ApiProperty } from '@nestjs/swagger';
import {
  IsDate,
  IsDateString,
  IsNotEmpty,
  IsNumber,
  IsOptional,
  IsString,
  MaxLength,
  Min,
  MinLength,
} from 'class-validator';

export interface RegistrarCompra {
  fechaCompra: Date;
  propiedadId: string;
  precioCompra: number;
  empleadoCompradorId: string;
}

export class RegistrarCompraDTO implements RegistrarCompra {
  @ApiProperty({
    description: 'Fecha de la compra',
    example: '2021-09-30',
    required: true,
    nullable: false,
  })
  @IsDateString()
  @IsNotEmpty()
  fechaCompra: Date;

  //--------------------------------------------------------------------------------
  @ApiProperty({
    description: 'Id de la propiedad comprada',
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
    description: 'Precio de la compra',
    example: 305120.75,
    required: true,
    nullable: false,
  })
  @IsNumber()
  @IsNotEmpty()
  precioCompra: number;

  //--------------------------------------------------------------------------------
  @ApiProperty({
    description: 'Id del empleado que realizó la compra',
    example: 'EM98101cef',
    required: true,
    nullable: false,
  })
  @IsString()
  @MinLength(10)
  @MaxLength(10)
  @IsNotEmpty()
  empleadoCompradorId: string;
}
