la otra parte:
import { ModernHero } from "./NewHomeHero";


  //new changes in Home function
  const tHome = await getTranslations({ locale, namespace: "home" });
  const tCommon = await getTranslations({ locale, namespace: "common" });

//where hero
<ModernHero 
        tagline={tCommon('new')} // O puedes usar la lógica de changelog si la necesitas
          title={tHome('hero.title')}
          subtitle={tHome('hero.subtitle')}
          description={tHome('hero.description')}
          ctaMain={tHome('hero.cta_main_temp')}
          ctaSecondary={tHome('hero.cta_secondary')}
          authorityBadge={tHome('hero.authority_badge')}
          images={[
            "https://images.unsplash.com/photo-1611162617213-7d7a39e9b1d7?q=80&w=400", // Ejemplo: Meta Ads
            "https://images.unsplash.com/photo-1460925895917-afdab827c52f?q=80&w=400", // Ejemplo: Analítica
            "https://images.unsplash.com/photo-1635070041078-e363dbe005cb?q=80&w=400", // Ejemplo: IA
            "https://images.unsplash.com/photo-1620712943543-bcc4688e7485?q=80&w=400", // Ejemplo: Automatización
          ]}
        />

Principal:
'use client';

import React from "react";
import { motion, Variants } from "framer-motion";
import { Link } from "@/i18n/routing";

interface ModernHeroProps {
  title: string;
  subtitle: string;
  description: string;
  ctaMain: string;
  ctaSecondary: string;
  authorityBadge: string;
}

const DEMO_IMAGES = [
  "https://images.unsplash.com/photo-1756312148347-611b60723c7a?w=900&auto=format&fit=crop&q=60",
  "https://images.unsplash.com/photo-1757865579201-693dd2080c73?w=900&auto=format&fit=crop&q=60",
  "https://images.unsplash.com/photo-1756786605218-28f7dd95a493?w=900&auto=format&fit=crop&q=60",
  "https://images.unsplash.com/photo-1757519740947-eef07a74c4ab?w=900&auto=format&fit=crop&q=60",
  "https://images.unsplash.com/photo-1757263005786-43d955f07fb1?w=900&auto=format&fit=crop&q=60",
  "https://images.unsplash.com/photo-1757207445614-d1e12b8f753e?w=900&auto=format&fit=crop&q=60",
];

export const ModernHero: React.FC<ModernHeroProps> = ({
  title, subtitle, description, ctaMain, ctaSecondary, authorityBadge
}) => {
  
  const containerVariants: Variants = {
    hidden: { opacity: 0 },
    show: {
      opacity: 1,
      transition: { staggerChildren: 0.25 }
    }
  };

  const itemVariants: Variants = {
    hidden: { opacity: 0, y: 15 },
    show: { opacity: 1, y: 0, transition: { type: "spring", stiffness: 100, damping: 20 } }
  };

  const marqueeImages = [...DEMO_IMAGES, ...DEMO_IMAGES, ...DEMO_IMAGES];

  return (
    <section className="relative w-full h-screen max-h-screen overflow-hidden bg-transparent flex flex-col items-center justify-start text-center px-4 pt-12 md:pt-24">
      
      <motion.div 
        variants={containerVariants}
        initial="hidden"
        animate="show"
        className="z-10 flex flex-col items-center max-w-4xl"
      >
        {/* Títulos: Bajado de 7xl a 5xl/6xl para mejor encuadre */}
        <motion.h1 className="text-4xl md:text-5xl lg:text-5xl font-extrabold tracking-tighter text-theme-primary mb-4 leading-[1.15]">
          <motion.span variants={itemVariants} className="block">
            {title}
          </motion.span>
          <motion.span 
            variants={itemVariants} 
            className="block bg-gradient-to-r from-blue-400 to-indigo-500 bg-clip-text text-transparent py-1"
          >
            {subtitle}
          </motion.span>
        </motion.h1>

        {/* Descripción */}
        <motion.p variants={itemVariants} className="max-w-xl text-base md:text-lg text-theme-secondary leading-relaxed mb-8 opacity-90">
          {description}
        </motion.p>

        {/* Botones */}
        <motion.div variants={itemVariants} className="flex flex-col sm:flex-row gap-4 mb-10">
          <Link href="/subscribe" className="btn-primary px-7 py-3 text-base font-bold shadow-lg shadow-primary-500/20">
            {ctaMain}
          </Link>
        </motion.div>

        {/* Badge de Meta (Sello final) */}
        <motion.div variants={itemVariants}>
          <div className="inline-flex items-center gap-3 px-4 py-2 rounded-full border border-primary-500/20 bg-white/5 backdrop-blur-sm">
            <img 
              src="https://markettai-public.b-cdn.net/web/Home-Meta.png" 
              alt="Meta Partner" 
              className="w-4 h-2.5 object-contain opacity-70" 
            />
            <span className="text-[10px] font-bold text-theme-primary uppercase tracking-[0.15em]">
              {authorityBadge}
            </span>
          </div>
        </motion.div>
      </motion.div>

      {/* Carrusel: Bajado un poco más la altura para que no asome tras el texto */}
      <div className="absolute top-[35%] left-0 w-full h-[250px] [mask-image:linear-gradient(to_top,transparent,black_50%,transparent)] pointer-events-none">
        <motion.div 
          className="flex gap-6 items-center"
          animate={{ x: ["0%", "-33.33%"] }}
          transition={{ ease: "linear", duration: 40, repeat: Infinity }}
        >
          {marqueeImages.map((src, index) => (
            <div 
              key={index} 
              className="relative aspect-[4/5] h-[160px] md:h-[200px] flex-shrink-0"
              style={{ rotate: `${(index % 2 === 0 ? -1 : 1)}deg` }}
            >
              <img 
                src={src} 
                alt="Showcase" 
                className="w-full h-full object-cover rounded-2xl shadow-xl border border-white/5 opacity-40" 
              />
            </div>
          ))}
        </motion.div>
      </div>
    </section>
  );
};