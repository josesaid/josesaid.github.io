#!/usr/bin/env bash
# Creado: 2026-11-27 16:41:00 (America/Mexico_City, UTC-06:00)
# Antes: upload_repo.sh (versión 16:39:00)
# upload_repo.sh: crea el JSON de valores con valores por defecto, sin pasar por el formulario.
# Cada valor se puede cambiar con una opción. Usa -h para ver la ayuda.
set -eu

if [ -t 1 ]; then
  C_RST=$'\033[0m'; C_NEG=$'\033[1m'; C_OPC=$'\033[1;36m'; C_VAL=$'\033[33m'
  C_OK=$'\033[1;32m'; C_ERR=$'\033[1;31m'; C_DIM=$'\033[2m'
else
  C_RST=""; C_NEG=""; C_OPC=""; C_VAL=""; C_OK=""; C_ERR=""; C_DIM=""
fi
ARGS_ORIGINALES="$*"

RUTA_DEF="/Users/josesaidolanogarcia/REPOSITORIOS/Langchain4j_Samples_Created_by_Said/01 - Basics/02-ai-services"
DESTINO_DEF="/Users/josesaidolanogarcia/Temporalito"
DESCRIPCION_DEF="Declare a Java interface, and LangChain4J generates the implementation that calls Claude."
ANCLA_DEF="LangChain4j"
VISIBILIDAD_DEF="publica"

RUTA="$RUTA_DEF"
NOMBRE=""
DESCRIPCION="$DESCRIPCION_DEF"
ANCLA="$ANCLA_DEF"
VISIBILIDAD="$VISIBILIDAD_DEF"
DESTINO="$DESTINO_DEF"
SOBRESCRIBIR=0

ayuda() {
  local O="$C_OPC" V="$C_VAL" R="$C_RST" D="$C_DIM" N="$C_NEG"
  printf '%bUso:%b bash upload_repo.sh [opciones]\n\n' "$N" "$R"
  printf 'Crea el JSON de valores con los valores por defecto, sin usar el formulario.\n\n'
  printf '%bOpciones:%b\n' "$N" "$R"
  printf '  %b-r, --ruta%b RUTA           Carpeta del repositorio\n' "$O" "$R"
  printf '                            %s(por defecto: %b%s%b)%s\n' "$D" "$V" "$RUTA_DEF" "$D" "$R"
  printf '  %b-n, --nombre%b NOMBRE       Nombre del repositorio\n' "$O" "$R"
  printf '                            %s(por defecto: nombre de la carpeta)%s\n' "$D" "$R"
  printf '  %b-d, --descripcion%b TEXTO   Descripción del repositorio\n' "$O" "$R"
  printf '                            %s(por defecto: texto del proyecto de ejemplo)%s\n' "$D" "$R"
  printf '  %b-a, --ancla%b TEXTO         Ancla de la lista\n' "$O" "$R"
  printf '                            %s(por defecto: %b%s%b)%s\n' "$D" "$V" "$ANCLA_DEF" "$D" "$R"
  printf '  %b-v, --visibilidad%b VALOR   publica o privada\n' "$O" "$R"
  printf '                            %s(por defecto: %b%s%b)%s\n' "$D" "$V" "$VISIBILIDAD_DEF" "$D" "$R"
  printf '  %b-t, --destino%b CARPETA     Carpeta donde se guarda el JSON\n' "$O" "$R"
  printf '                            %s(por defecto: %b%s%b)%s\n' "$D" "$V" "$DESTINO_DEF" "$D" "$R"
  printf '  %b-o, --sobrescribir%b        Permite reemplazar un JSON existente con el mismo nombre\n' "$O" "$R"
  printf '                            %s(por defecto: no reemplaza y sale con código 1)%s\n' "$D" "$R"
  printf '  %b-h, --help%b                Muestra esta ayuda y sale\n\n' "$O" "$R"
  printf '%bEjemplo:%b\n' "$N" "$R"
  printf '  bash upload_repo.sh -r "/ruta/a/mi-repo" -a Kafka -v privada\n'
}

while [ $# -gt 0 ]; do
  case "$1" in
    -r|--ruta)         RUTA="${2:?Falta la ruta después de $1}"; shift 2 ;;
    -n|--nombre)       NOMBRE="${2:?Falta el nombre después de $1}"; shift 2 ;;
    -d|--descripcion)  DESCRIPCION="${2:?Falta la descripción después de $1}"; shift 2 ;;
    -a|--ancla)        ANCLA="${2:?Falta el ancla después de $1}"; shift 2 ;;
    -v|--visibilidad)  VISIBILIDAD="${2:?Falta la visibilidad después de $1}"; shift 2 ;;
    -t|--destino)      DESTINO="${2:?Falta la carpeta después de $1}"; shift 2 ;;
    -o|--sobrescribir) SOBRESCRIBIR=1; shift ;;
    -h|--help)         ayuda; exit 0 ;;
    *)
      echo "${C_ERR}❌ Opción no reconocida:${C_RST} ${C_VAL}$1${C_RST}" >&2
      echo "   Usa ${C_OPC}-h${C_RST} o ${C_OPC}--help${C_RST} para ver las opciones." >&2
      exit 2 ;;
  esac
done

case "$VISIBILIDAD" in
  publica|privada) ;;
  *) echo "${C_ERR}❌ La visibilidad debe ser${C_RST} ${C_VAL}publica${C_RST} o ${C_VAL}privada${C_RST}" >&2; exit 2 ;;
esac

if [ ! -d "$RUTA" ]; then
  echo "${C_ERR}❌ No existe la carpeta:${C_RST} ${C_VAL}$RUTA${C_RST}" >&2
  exit 1
fi

[ -n "$NOMBRE" ] || NOMBRE="$(basename "$RUTA")"
STAMP="$(date +%Y%m%d-%H%M%S)"
TRACK_FECHA="$(date +%Y-%m-%d)"
TRACK_HORA="$(date +%H:%M:%S)"
TRACK_ZONA="$(date +%Z)"
TRACK_OFFSET="$(date +%z)"
TRACK_EPOCH="$(date +%s)"
TRACK_ISO="$(date +%Y-%m-%dT%H:%M:%S%z)"
TRACK_HOST="$(hostname -s 2>/dev/null || echo desconocido)"
TRACK_USUARIO="${USER:-desconocido}"
TRACK_SCRIPT="upload_repo.sh"
TRACK_VERSION="2026-11-27 16:41:00"
TRACK_ARGS="$ARGS_ORIGINALES"
mkdir -p "$DESTINO"
SALIDA="$DESTINO/subir-repo-$NOMBRE-$STAMP.json"
if [ -e "$SALIDA" ] && [ "$SOBRESCRIBIR" -eq 0 ]; then
  echo "${C_ERR}❌ Ya existe:${C_RST} ${C_VAL}$SALIDA${C_RST}" >&2
  echo "   Usa ${C_OPC}-o${C_RST} o ${C_OPC}--sobrescribir${C_RST} para reemplazarlo." >&2
  exit 1
fi

python3 - "$SALIDA" "$RUTA" "$NOMBRE" "$DESCRIPCION" "$VISIBILIDAD" "$ANCLA" \
  "$TRACK_FECHA" "$TRACK_HORA" "$TRACK_ZONA" "$TRACK_OFFSET" "$TRACK_EPOCH" "$TRACK_ISO" \
  "$TRACK_HOST" "$TRACK_USUARIO" "$TRACK_SCRIPT" "$TRACK_VERSION" "$TRACK_ARGS" <<'PY'
import json, sys

(salida, ruta, nombre, descripcion, visibilidad, ancla,
 fecha, hora, zona, offset, epoch, iso, host, usuario, script, version, args) = sys.argv[1:18]
valores = {
    "ruta": ruta,
    "nombre": nombre,
    "descripcion": descripcion,
    "visibilidad": visibilidad,
    "tema_pages": "al_azar",
    "tema_manual": "jekyll-theme-cayman",
    "pages": "si",
    "diagramas": "no incluir",
    "blog": "entrada",
    "articulo_devto": "no",
    "articulo_url": "(entonces lo crearé)",
    "articulo_titulo": "Stop Writing Glue Code: AI in Java, the Clean Way",
    "popup_josesaid": "si",
    "popup_texto": "New project: 02 Ai Services",
    "ancla": ancla,
    "linkedin": "publicar",
    "linkedin_skill": "anthropic-skills:post-random-topic-linkedin-devto",
    "linkedin_proyecto": "What I Learned Building 02 Ai Services in Java",
    "tracking": {
        "fecha": fecha,
        "hora": hora,
        "zona_horaria": zona,
        "desfase_utc": offset,
        "fecha_hora_iso": iso,
        "epoch": int(epoch),
        "host": host,
        "usuario": usuario,
        "script": script,
        "version_script": version,
        "argumentos": args,
    },
}
with open(salida, "w", encoding="utf-8") as f:
    json.dump(valores, f, ensure_ascii=False, indent=2)
    f.write("\n")
PY

echo "${C_OK}✅ Valores por defecto creados${C_RST} ${C_DIM}($TRACK_ISO)${C_RST}"
echo "📄 ${C_VAL}$SALIDA${C_RST}"
