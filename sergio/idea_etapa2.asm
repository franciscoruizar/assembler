

mensaje="mtqf jxyj rjsxfoj jxyÑ jshwnuyfit"
clave= "este"


int obtiene_clave(Strting mensaje; String clave){
    boolean primerLetraPalabra=true;
    boolean vale=true;
    posicionMensaje=0;
    posicionClave=0;
    clave_posible=0;

    while(posicionMensaje<mensaje.lenght){

        if(primerLetraPalabra && posicionClave==0){
        clave_posible=mensaje.charAt(posicionMensaje)-mensaje.charAt(posicionClave)
        vale=true;
        primerLetraPalabra=false;
        }

        if(mensaje.charAt(posicionMensaje)-mensaje.charAt(posicionClave)!=clave_posible){
                vale=false;
        }

        if(mensaje.charAt(posicionMensaje)==" "){
                if(vale){
                    return clave_posible;
                }
                esle{
                    primerLetraPalabra=true;
                    posicionClave=0;
                }
        }

        posicionClave++
        posicionMensaje++


    }





}