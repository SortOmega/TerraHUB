import { ApiProperty } from '@nestjs/swagger';
import {
  IsNotEmpty,
  IsNumber,
  IsOptional,
  IsString,
  Max,
  MaxLength,
  MinLength,
} from 'class-validator';

export class EtiquetaDTO {
  @ApiProperty({
    description: 'Id de la propiedad',
    example: 'ETfwafgwax',
    required: true,
    nullable: false,
  })
  @IsString()
  @MinLength(10)
  @MaxLength(10)
  @IsNotEmpty()
  etiquetaId: string;

  //----------------------------------------------
  @ApiProperty({
    description: 'Cantidad de elementos según descripción de la etiqueta',
    example: 2,
    required: false,
    nullable: true,
  })
  @IsNumber()
  @IsOptional()
  cantidad: string;
}
