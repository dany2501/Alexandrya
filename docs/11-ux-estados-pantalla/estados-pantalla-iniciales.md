# 11 — Estados de Pantalla Iniciales

Wireframes textuales (baja fidelidad) y estados de cada pantalla clave. Definen contenido, acciones y estados (vacío, carga, error, éxito) antes del diseño UI de alta fidelidad. Cada estado es `EP-###`.

> Convención de estados: **Default** (normal), **Loading**, **Empty** (sin datos), **Error**, **Success**.

---

## MOD-01 · Landing pública

### EP-001 — Home / Hero
```
┌───────────────────────────────────────────────┐
│  Alexandrya            Materias  Planes  [Entrar]│
├───────────────────────────────────────────────┤
│   Prepárate y aprueba.                          │
│   Exámenes, simuladores y seguimiento.          │
│            [ Ver planes ]   [ Cómo funciona ]   │
├───────────────────────────────────────────────┤
│  ✅ 11 materias  ✅ Simuladores   ✅ Tu progreso│
└───────────────────────────────────────────────┘
```
- **Acciones:** Ver planes (→ EP-002), Entrar (→ EP-011), navegar secciones.

### EP-002 — Planes y precios
```
┌───────────────────────────────────────────────┐
│              PLAN ANUAL ALEXANDRYA              │
│   ┌─────────────────────────────────────────┐  │
│   │  Acceso total · 11 materias             │  │
│   │  Simuladores + dashboard + material     │  │
│   │  $ ____ MXN / año                       │  │
│   │            [ Suscribirme ]              │  │
│   └─────────────────────────────────────────┘  │
│   Métodos: Tarjeta · SPEI                       │
└───────────────────────────────────────────────┘
```
- **Acciones:** Suscribirme (→ registro/checkout EP-020).

### EP-003 — Contacto
- **Default:** formulario (nombre, correo, mensaje) + correo + redes.
- **Success:** "Gracias, te contactaremos." · **Error:** "No se pudo enviar, reintenta."

---

## MOD-02 · Identidad y acceso

### EP-010 — Registro
```
┌─────────────────────────────┐
│        Crear cuenta         │
│  Correo  [_______________]  │
│  Contraseña [____________]  │
│  Confirmar  [____________]  │
│  □ Acepto términos          │
│      [ Registrarme ]        │
│  ¿Ya tienes cuenta? Entrar  │
└─────────────────────────────┘
```
- **Estados:** Error (correo ya usado → RNA-001), Success (→ EP-012 verificación enviada).

### EP-011 — Login
```
┌─────────────────────────────┐
│       Iniciar sesión        │
│  Correo  [_______________]  │
│  Contraseña [____________]  │
│  □ Recordarme               │
│      [ Entrar ]             │
│  ¿Olvidaste tu contraseña?  │
└─────────────────────────────┘
```
- **Default / Loading / Error** (credenciales inválidas, intentos restantes → FA-001).

### EP-012 — Verificación de correo enviada
- "Te enviamos un enlace a tu correo. Revísalo para activar tu cuenta." · Acción: reenviar.

### EP-013 — Bloqueo por intentos (rate limit)
```
┌─────────────────────────────┐
│  🔒 Cuenta bloqueada         │
│  Demasiados intentos.        │
│  Reintenta en 14:59          │
└─────────────────────────────┘
```
- Asociado a FA-003 / RNA-003.

### EP-014 — Recuperar / cambiar contraseña
- **Recuperar:** ingresar correo → "Te enviamos instrucciones."
- **Cambiar:** nueva contraseña + confirmar → Success.

### EP-015 — Aviso de inactividad
```
┌─────────────────────────────────────┐
│  ⏳ ¿Sigues ahí?                      │
│  Por seguridad cerraremos tu sesión  │
│  en 00:60 por inactividad.           │
│   [ Seguir conectado ]  [ Salir ]    │
└─────────────────────────────────────┘
```
- **Aviso (min 9):** modal con cuenta regresiva → [MSG-029](../14-mensajes-sistema/mensajes-sistema.md#msg-02x--identidad-y-acceso-mod-02). "Seguir conectado" reinicia el contador.
- **Cerrada (min 10):** redirige a login con [MSG-02A](../14-mensajes-sistema/mensajes-sistema.md#msg-02x--identidad-y-acceso-mod-02). Asociado a [RN-035](../06-reglas-negocio/reglas-principales.md#control-de-sesiones) / [RNA-007](../06-reglas-negocio/reglas-alternas.md) / [RF-080](../05-requerimientos/RF-080-sesion-unica.md).

---

## MOD-03 · Suscripción y pagos

### EP-020 — Checkout
```
┌───────────────────────────────────────┐
│  Plan anual — $ ____ MXN               │
│  Método:  ( ) Tarjeta   ( ) SPEI       │
│  [ datos de pago ]                     │
│            [ Pagar ]                   │
└───────────────────────────────────────┘
```
- **Loading** (procesando), **Error** (pago rechazado → FA-010), **Success** (→ EP-021).

### EP-021 — Suscripción activa / estado
```
┌───────────────────────────────────────┐
│  ✅ Suscripción activa                  │
│  Vence: 18/06/2027  (365 días)         │
│  [ Renovar ]                           │
└───────────────────────────────────────┘
```
- **Variante vencida (EP-022):** "⚠️ Tu suscripción venció. Renueva para continuar." + [Renovar].

---

## MOD-05 · Evaluaciones

### EP-040 — Selección de evaluación
```
┌───────────────────────────────────────┐
│  Materia: [ Matemáticas ▾ ]            │
│  Tipo: (•)Tema ( )Módulo ( )Simulador  │
│  Tema: [ Álgebra ▾ ]                   │
│            [ Comenzar ]                │
└───────────────────────────────────────┘
```

### EP-041 — Reactivo en curso
```
┌───────────────────────────────────────┐
│  Reactivo 3/20            ⏱ 12:45      │
│  Calcular f''(x) de  f(x)=9·cos(x/3)   │  ← enunciado con fórmula (LaTeX)
│  ( ) A) f''(x)=3·cos(x/3)              │
│  ( ) B) f''(x)=⅓·cos(x/3)              │  ← opciones renderizadas como fórmula
│  ( ) C) f''(x)=cos(x/3)                │
│  ( ) D) f''(x)=−cos(x/3)               │
│  [imagen/video si aplica]              │
│            [ Siguiente ]               │
└───────────────────────────────────────┘
```
- **Render:** enunciado y opciones se muestran según su `formato` (texto/markdown/**latex**/html); las fórmulas se renderizan, no aparecen como código ([RF-033](../05-requerimientos/RF-033-contenido-reactivo.md)).
- **Opción con imagen:** una opción puede ser un diagrama en lugar de texto.
- **Empty:** "Este tema aún no tiene preguntas." (RNA-032).

### EP-041b — Reactivo con estímulo (comprensión lectora / caso)
```
┌──────────── Lectura (estímulo) ─────────┐  ┌──────── Reactivo 2/5 ────────┐
│ Carlomagno y los países bajos            │  │ Según el párrafo [2], ¿quién  │
│ [1] A mediados del siglo VIII...         │  │ conquistó la ciudad de        │
│ [2] ...participaron en las gestas¹...    │  │ Utrecht?                      │
│     Adalardo, Rolando y Guillermo...     │  │ ( ) A) Rolando                │
│ ¹ Conjunto de hazañas.                   │  │ ( ) B) Adalardo               │
│ (panel con scroll, se mantiene visible)  │  │ ( ) C) Guillermo ( ) D) Carlo.│
│                                          │  │        [ Siguiente ]          │
└──────────────────────────────────────────┘  └──────────────────────────────┘
```
- El **texto base se muestra una vez** y permanece visible mientras se responden sus reactivos en orden ([RN-008](../06-reglas-negocio/reglas-principales.md), [RF-033](../05-requerimientos/RF-033-contenido-reactivo.md)).
- En móvil (Android), el estímulo se muestra colapsable arriba del reactivo o en una pestaña "Lectura".

### EP-042 — Retroalimentación de pregunta
```
┌───────────────────────────────────────┐
│  ✅ Correcto  /  ❌ Incorrecto          │
│  Respuesta correcta: B) 2x             │
│  Explicación: ...                      │
│  💡 Tip: ...                            │
└───────────────────────────────────────┘
```

### EP-043 — Resultado del intento
```
┌───────────────────────────────────────┐
│  Calificación: 16/20 (80%)             │
│  Tiempo: 14:20                         │
│  Aciertos por tema: ▇▇▇▁▁              │
│  [ Ver explicaciones ] [ Reintentar ]  │
└───────────────────────────────────────┘
```

---

## MOD-06 · Progreso

### EP-050 — Dashboard
```
┌───────────────────────────────────────┐
│  Avance general: ███████░░ 72%         │
│  Por materia:                          │
│   Matemáticas ████████░ 85%            │
│   Química     █████░░░░ 55%  ← débil   │
│  Áreas de oportunidad: Química, Física │
│  Recomendación: repasa "Estequiometría"│
└───────────────────────────────────────┘
```
- **Empty:** "Aún no tienes intentos. Haz tu primera evaluación."

---

## MOD-07 · Material

### EP-060 — Visor de material
- Reproductor embebido (video/PDF/imagen), **sin botón de descarga**, con watermark del alumno. En Android, `FLAG_SECURE` activo (EP muestra negro ante captura).

---

## MOD-08 · Referidos

### EP-070 — Mis referidos
```
┌───────────────────────────────────────┐
│  Tu código: ALEX-7Q2X   [ Copiar ]     │
│  [ Compartir ]                         │
│  Referidos: ●●○  (2/3 efectivos)       │
│  Beneficios obtenidos:                 │
│   1) Exámenes ilimitados ✅            │
│   2) Material premium ✅               │
│   3) Extensión —                       │
└───────────────────────────────────────┘
```

---

## MOD-10 · Panel administrativo

### EP-090 — Dashboard admin
- Tarjetas: usuarios activos, suscripciones por vencer, ingresos, intentos. Accesos a: Contenido, Usuarios, Pagos, Referidos, Reportes, Carga masiva.

---

## MOD-12 · Anuncios

### EP-100 — Anuncios
```
Banner:                                  Modal crítico:
┌────────────────────────────────────┐   ┌─────────────────────────────┐
│ ℹ️ {{titulo}} — {{cuerpo}}   [x]    │   │  {{titulo}}                 │
│                        [{{cta}}]   │   │  {{cuerpo}}                 │
└────────────────────────────────────┘   │       [ Entendido ]         │
Centro de anuncios:                       └─────────────────────────────┘
┌────────────────────────────────────┐
│ Anuncios                            │
│ • {{titulo}}          {{fecha}}     │
│ (vacío) "No tienes anuncios."       │  ← MSG-121
└────────────────────────────────────┘
```
- **Default:** banner/modal/centro según canal → [MSG-120](../14-mensajes-sistema/mensajes-sistema.md#msg-12x--anuncios-mod-12).
- **Empty:** [MSG-121](../14-mensajes-sistema/mensajes-sistema.md#msg-12x--anuncios-mod-12). **Crítico:** modal con acuse → [MSG-123](../14-mensajes-sistema/mensajes-sistema.md#msg-12x--anuncios-mod-12).
- Asociado a [RF-120](../05-requerimientos/RF-120-anuncios.md) / [RN-120-01..03](../06-reglas-negocio/reglas-principales.md#anuncios).

---

## Índice de estados

| EP | Pantalla | Módulo | Caso de uso |
|----|----------|--------|-------------|
| EP-001..003 | Landing (home, planes, contacto) | MOD-01 | CU-010 |
| EP-010..015 | Registro, login, verificación, bloqueo, contraseña, inactividad | MOD-02 | CU-001..003 |
| EP-020..022 | Checkout, estado de suscripción | MOD-03 | CU-020, CU-021 |
| EP-040..043 | Selección, pregunta, feedback, resultado | MOD-05 | CU-040 |
| EP-050 | Dashboard de progreso | MOD-06 | CU-050 |
| EP-060 | Visor de material | MOD-07 | CU-060 |
| EP-070 | Mis referidos | MOD-08 | CU-070 |
| EP-090 | Dashboard admin | MOD-10 | CU-090 |

<!-- FOOTER:ALEXANDRYA -->

---

<sub>📄 **Alexandrya** · `docs/11-ux-estados-pantalla/estados-pantalla-iniciales.md` · Versión documental **v0.3.0** · Actualizado **2026-06-19** · 🏠 [Índice](../README.md) · 💬 [Mensajes del sistema](../14-mensajes-sistema/mensajes-sistema.md)</sub>
