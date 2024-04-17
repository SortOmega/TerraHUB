import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsOptional, IsString, Max, MaxLength, MinLength } from 'class-validator';

export class EtiquetaDTO {
  @ApiProperty({
    description: 'Id de la propiedad',
    example: 'Casa',
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
    example: 'Casa',
    required: false,
    nullable: true,
  })
  @IsString()
  @MinLength(10)
  @MaxLength(10)
  @IsOptional()
  cantidad: string;
}
