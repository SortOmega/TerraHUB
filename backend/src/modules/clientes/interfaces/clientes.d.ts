interface TipoCliente {
  tipoClienteId: string;
  descripcion: string;
}

interface Cliente {
  clienteId: string;
  nombre: string;
  identidad: string;
  email: string;
  telefono: string;
  tipoClienteId: string;
}
