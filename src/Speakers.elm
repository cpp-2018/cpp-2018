module Speakers exposing (Speaker, speakers)

import Accessibility as Html exposing (Html, text)
import Style exposing (class)


---- TYPES ----


type alias Speaker =
    { name : String
    , image : String
    , bio : Html Never
    }



---- HELPERS ----


bold : String -> Html Never
bold text =
    Html.span [ class [ Style.SpeakerModalName ] ]
        [ Html.text text
        ]


paragraph : List (Html Never) -> Html Never
paragraph content =
    Html.p [] content


getImageUrl : String -> String
getImageUrl fileName =
    "/build/assets/speakers/" ++ fileName



---- SPEAKERS ----


speakers : List Speaker
speakers =
    [ Speaker
        "Michael Ashton, PhD"
        (getImageUrl "michael-ashton.jpg")
        (Html.div []
            [ paragraph
                [ bold "Michael Ashton"
                , text " is an expert in pharmacokinetics (PK), drug metabolism (DM), pharmacodynamics (PD) and quantitative drug analysis in blood plasma. His major research topic has been new drug treatments of “under-researched” infectious diseases. In the past 30 years his special interest has focused the artemisinin antimalarials, for which his research has yielded important insights into their unusual pharmacokinetics and metabolic transformation in the body. These drugs have today become global first-line treatment of falciparum malaria. The 1972 discovery and isolation of artemisinin from the leaves of an indigenous Chinese shrub was awarded the 2015 Nobel Prize. Other therapy areas are African sleeping sickness and TB/HIV co-infection."
                ]
            , paragraph
                [ text "The explorative use of psychedelics as psychotherapy tools requires a better understanding on how their effects are related to drug exposure. He expects his main contribution to be within PK/PD mathematical modelling and simulation to better understand static and time-related relationships between drug concentrations (PK) and elicited effects (PD)."
                ]
            , paragraph
                [ text "He is since 2001 professor of biopharmacy at the University of Gothenburg, heading its Unit for Pharmacokinetics and Drug Metabolism (PKDM). He has working experience from both drug regulation (Medical Products Agency, Uppsala) and drug development (AstraZeneca, Gothenburg)."
                ]
            ]
        )
    , Speaker
        "Alex Belser, PhD"
        (getImageUrl "alex-belser.jpg")
        (paragraph
            [ bold "Alexander Belser, Ph.D. Candidate, M.Phil.,"
            , text " is a Clinical Research Fellow at Yale University.  Alex was a founding member of the Psychedelic Research Group at New York University (NYU) in 2006.  There he conducted a qualitative study exploring how cancer patients experience psilocybin-assisted psychotherapy.  Alex serves as a scientific collaborator for a qualitative study investigating psilocybin-assisted psychotherapy as a treatment for alcohol addiction. He is also interviewing religious leaders who are administered psilocybin.  Alex has published a number of peer-reviewed articles and book chapters, and serves as a peer reviewer for the Journal of Psychopharmacology. Alex graduated from Georgetown University, and pursued graduate studies at Cambridge University, NYU, and Columbia University.  As a clinician, Alex treats patients with trauma in a multi-site trial of MDMA-assisted psychotherapy as a treatment for post-traumatic stress disorder (PTSD), which was recently designated a “breakthrough therapy” by the Food and Drug Administration (FDA).  Alex completed his clinical and research training in psychology at Bellevue Hospital, New York Psychiatric Institute at Columbia University Medical Center, and Mount Sinai Beth Israel Hospital."
            ]
        )
    , Speaker
        "Alicia Danforth, PhD"
        (getImageUrl "alicia-danforth.jpg")
        (paragraph
            [ bold "Alicia Danforth, Ph.D.,"
            , text " is a licensed clinical psychologist and researcher in California. She has recently finalized a pilot study on MDMA-assisted therapy for the treatment of social anxiety in autistic adults, and is currently lead clinician and supervisor for a clinical trial at UCSF on psilocybin-assisted group therapy for psychological distress in long-term survivors of HIV/AIDS. She began her work in psychedelic research as a study coordinator and co-facilitator on Dr. Charles Grob's Phase 2 pilot study of psilocybin treatment for existential anxiety related to advanced cancer. At the Institute of Transpersonal Psychology, she co-developed and taught the first graduate-level course on psychedelic theory, research, and clinical considerations for therapists and researchers in training with James Fadiman, PhD and David Lukoff, PhD. Alicia is also a nationally certified Trauma-Focused CBT therapist."
            ]
        )
    , Speaker
        "David Erritzøe, MRPsych PhD"
        (getImageUrl "david-erritzoe.jpg")
        (paragraph
            [ bold "David Erritzøe"
            , text " currently works as a post-doctoral researcher and Academic Clinical Fellow at the  Centre for Neuropsychopharmacology, Division of Brain Sciences, Imperial College London. For the last 9 years he has been working with Professor David Nutt and Robin Carhart-Harris, conducting the first imaging studies with MDMA, LSD and psilocybin as well as doing clinical research with psilocybin in depressed patients. He first graduated from Copenhagen Medical School in 2001, moving onwards to work under Professor Marc Laruelle at Columbia University in New York City after his medical training. Specializing in molecular brain imaging in schizophrenia and addiction, he then completed his PhD on PET studies of serotonergic neurotransmission, completed at the Neurobiology Research Unit and Center for Integrated Molecular Brain Imaging (CIMBI), University Hospital Rigshospitalet, Copenhagen. David is involved in several lines of psychopharmacological and brain imaging research at Imperial; investigating dopaminergic neurotransmission with measurements of the dopamine D3 receptor in alcohol addiction, studies of opioid neurotransmission in pathological gambling, and functional imaging studies looking at the role of dopamine D3 and mu-opiate receptors in cocaine, alcohol, and heroin addiction. Since he was nominated an Academic Clinical Fellowship in Psychiatry under Imperial College in 2012, he has been working part time in clinical psychiatry in West London, as well as doing research."
            ]
        )
    , Speaker
        "Débora González, PhD"
        (getImageUrl "debora-gonzalez.jpg")
        (paragraph
            [ bold "Débora González, Ph.D."
            , text ", is a Clinical Psychologist with a Ph.D. in Pharmacology. Her doctoral work was supported by a fellowship from the Spanish government. She is co-author of several scientific papers and book chapters about ayahuasca, 2C-B, Salvia divinorum and research chemicals. She is currently conducting a longitudinal study on the long-term effects of ayahuasca on well-being and health of Western users with ICEERS Foundation and a pilot study of the treatment for complicated grief, involving holotropic breathwork and ayahuasca as therapeutic tools, with PHI Association."
            ]
        )
    , Speaker
        "Charles Grob, MD"
        (getImageUrl "charles-grob.jpg")
        (paragraph
            [ bold "Charles S. Grob, M.D.,"
            , text " is Director of the Division of Child and Adolescent Psychiatry at Harbor-UCLA Medical Center, and Professor of Psychiatry and Pediatrics at the UCLA School of Medicine. Dr. Grob conducted the first government approved psychobiological research study of MDMA, and was the principal investigator of an international research project in the Brazilian Amazon studying the psychedelic plant brew, ayahuasca. He has also completed and published the first approved research investigation in several decades on the safety and efficacy of psilocybin treatment in terminal cancer patients with anxiety. Together with Alicia Danforth, he recently completed a pilot investigation into the use of an MDMA treatment model for social anxiety in autistic adults. Dr. Grob is the editor of Hallucinogens: A Reader (Tarcher/Putnam, 2002) and co-editor (with Roger Walsh) of Higher Wisdom: Eminent Elders Explore the Continuing Impact of Psychedelics (SUNY Press, 2005). He is also a founding board member of the Heffter Research Institute."
            ]
        )
    , Speaker
        "Jeffrey Guss, MD"
        (getImageUrl "jeffrey-guss.jpg")
        (Html.div []
            [ paragraph
                [ bold "Jeffrey Guss, MD"
                , text " is a psychiatrist, psychoanalyst, and researcher with a specializations in psychoanalytic therapy and the treatment of substance used disorders. He was a Co-Principal Investigator, study therapist and the Director of Therapist Training for the NYU School of Medicine’s study on \"Psilocybin-Assisted Therapy in the treatment of existential distress related to Cancer Diagnosis and Treatment\", and is a co-author of “Rapid and Sustained Symptom Reduction Following Psilocybin Treatment for Anxiety and Depression in Patients with Life-Threatening Cancer: A Randomized Clinical Trial” published in Journal of Psychopharmacology, December 2016. He is currently a study therapist for NYU School of Medicine’s “RCT of Psilocybin Assisted Treatment of Alcohol Dependence."
                ]
            , paragraph [ text "Dr Guss is particularly interested in the integration of psychedelic therapies with contemporary models of psychodynamic therapy as mindfulness based therapy.  He is collaborating with Yale University on a psilocybin assisted therapy for depression that incorporates Acceptance and Commitment Therapy into traditional academic psychedelic therapy approach.  He is an Instructor, Mentor and on the Council of Advisors for the California Institute of Integral Studies’ Center for Psychedelic Therapies and Research and on the Advisory Board for the Center for Optimal Living’s Psychedelic Education and Continuing Care Program. He has published on the topics of gender and sexuality in Studies in Gender and Sexuality and Psychoanalysis, Culture and Society. Dr. Guss maintains a private practice of psychiatry and psychotherapy in New York City." ]
            ]
        )
    , Speaker
        "Boris Heifets, MD PhD"
        (getImageUrl "boris-heifets.jpg")
        (paragraph
            [ bold "Boris Heifets, M.D."
            , text ", Ph.D., has had a lifelong interest in how consciousness-altering drugs affect fundamental neural processes. He received his M.D. and Ph.D. in neuroscience from the Albert Einstein College of Medicine in New York, and came to Stanford University for residency training in anesthesiology. Since 2013, he has subspecialized in neuro-anesthesiology and joined the Stanford School of Medicine faculty. His laboratory research, under the guidance of Dr. Robert Malenka, an internationally recognized expert in the synaptic basis of learning, memory and addiction, focuses on the neural circuits underlying MDMA's pro-social effects in mice."
            ]
        )
    , Speaker
        "Matthew W. Johnson, PhD"
        (getImageUrl "matthew-w-johnson.jpg")
        (paragraph
            [ bold "Matthew W. Johnson, Ph.D."
            , text ", is Associate Professor of Psychiatry at Johns Hopkins University School of Medicine. Dr. Johnson is an experimental psychologist and an expert on psychoactive drugs, and in the psychology of addiction and risk behavior. For 19 years he has conducted academic research in psychopharmacology and addictions, and for >12 years he has conducted human research with psychedelics. Outside of his research on psychedelics, Dr. Johnson conducts behavioral economic research on decision making, addiction, and sexual risk behavior. Dr. Johnson has conducted studies with nearly all classes of psychoactive drugs. He has published 91 articles and chapters, with 32 focused primarily on psychedelics. Dr. Johnson was lead author on safety guidelines for human psychedelic research which were published in 2008, and which have facilitated the safe initiation of psychedelic research at an increasing number of universities. He is principal investigator of multiple psychedelic research studies at Johns Hopkins, and has been investigating psilocybin as a medication for tobacco smoking cessation since 2007. Dr. Johnson initiated the Johns Hopkins psilocybin cancer protocol with Dr. Roland Griffiths in 2005, and has recently co-authored results from this trial, showing psilocybin to cause large and sustained reductions in cancer-related symptoms of anxiety and depression. Dr. Johnson has served as a session guide for over 100 psychedelic sessions."
            ]
        )
    , Speaker
        "Mendel Kaelen, PhD"
        (getImageUrl "mendel-kaelen.jpg")
        (paragraph
            [ bold "Mendel"
            , text " is a neuroscientist and entrepreneur. He holds a Bsc and Msc in neuroscience from University of Groningen and a PhD in neuroscience from Imperial College London. His research focusses on the therapeutic function of set and setting in psychedelic therapy,  with a particular focus on music. He is founder and CEO of Wavepaths, a venture that unifies immersive arts, psychotherapies and intelligent technologies into a new category of therapeutic tools. His work has been featured in Rolling Stone, TEDx, Nature News, San Francisco Chronicles, Vice Motherboard, a.o. Mendel is a fellow of the European Institute for Technology and Innovation and currently lives in London."
            ]
        )
    , Speaker
        "Thomas Kingsley Brown, PhD"
        (getImageUrl "thomas-kingsley-brown.jpg")
        (paragraph
            [ bold "Thomas Kingsley Brown"
            , text " has been researching ibogaine treatment for substance dependence since 2009, when he began conducting interviews with people at a treatment center in Playas de Tijuana, Mexico and collected data for the purpose of studying quality of life for those people.  In 2010 he began working with MAPS (the Multidisciplinary Association for Psychedelic Studies) on a Mexico-based observational study of the long-term outcomes for people receiving ibogaine-assisted treatment for opioid dependence. That study is complete and the first research article on the study, co-authored with Dr. Kenneth Alper, has been published (American Journal of Drug and Alcohol Abuse, 2017). In 2013 he published a review article on ibogaine treatment in Current Drug Abuse Reviews. Dr. Brown is on staff at the University of California, San Diego as the Coordinator of the McNair Scholars Program, which prepares first-generation, low-income undergraduate students and those from under-represented ethnic groups for doctoral programs in all fields of study. His own academic training is in chemistry (B.S., University of Pittsburgh and M.S., California Institute of Technology), neuroscience, and anthropology (M.A. and PhD, UC San Diego)."
            ]
        )
    , Speaker
        "Jeffrey Kamlet, MD"
        (getImageUrl "jeffrey-kamlet.jpg")
        (Html.div []
            [ paragraph
                [ bold "Jeffrey Kamlet, M.D, FASAM, BABAM"
                , text " is recognized as the world expert on cardiac safety in ibogaine treatment. He is a fellow of the American Society of Addiction Medicine, and has twice served as President of the Florida Society of Addiction Medicine. Currently, Dr. Kamlet serves as GITA’s Chief Medical Advisor, as well as Editor in Chief on GITA’s Clinical Guidelines for Ibogaine-Assisted Detoxification."
                ]
            , paragraph [ text "In 1995, Dr. Kamlet was involved in early clinical trials, conducted under the direction of Deborah Mash, Ph.D., to assess ibogaine’s utility in the rapid-detoxification from opiate dependence and the reduction of post-acute withdrawal symptoms. Over the past 20 years he has witnessed over 1800 ibogaine treatments without a single adverse event, and continues to believes it to be one of the most important discoveries in the history of addiction medicine." ]
            , paragraph [ text "Dr. Kamlet holds a degree in Medicine and Surgery from the State University of New York. He received further training in neurology and psychiatry, and then a Cardiology Fellowship at the Mount Sinai Medical Center in Miami Beach Florida." ]
            , paragraph [ text "He has worked as an Associate Director and Medical Director for several emergency departments in Southern Florida, and sat on the board of the Florida American Heart Association, where he helped to update ACLS protocols. He has served as a principal investigator on over 20 major pharmaceutical trials, and has achieved accolades in the fields of hormonal replacement therapy, anti-aging medicine and neutriceuticals." ]
            ]
        )
    , Speaker
        "Kim Kuypers, PhD"
        (getImageUrl "kim-kuypers.jpg")
        (paragraph
            [ bold "Kim Kuypers, Ph.D."
            , text " has been studying the effects of MDMA on cognition for over 14 years. The research grant she obtained in 2011 helped her to set up her own research line in which she chose to shift her focus from negative drug effects to positive effects of drugs and underlying neurobiology. After finishing her master in neuropsychology at Maastricht University in 2002, Kim Kuypers started studying the effects of MDMA on cognitive, psychomotor and driving skills. In 2007 she obtained her PhD and continued this research line, focusing on the neurobiological mechanisms underlying MDMA-induced memory impairment using mechanistic pharmaco-studies and functional imaging techniques. In 2011, she received a grant from the Netherlands Organisation for Scientific Research. This helped her to set up her own research line in which she chose to shift her focus from negative drug effects (e.g. memory impairment) to positive effects (e.g. empathy, mood enhancement, creativity) of drugs (e.g. MDMA, cocaine, Ayahuasca). Since then she has been exploring this field. Her motivation for this shift in research focus was that by using the unique properties of these drugs a better understanding on the neurobiological mechanisms underlying these positive effects could be gained. This knowledge enables us to enhance social abilities and problem solving skills in daily life and in pathological populations in the future."
            ]
        )
    , Speaker
        "Alexander Lebedev, MD PhD"
        (getImageUrl "alexander-lebedev.jpg")
        (paragraph
            [ bold "Alexander V. Lebedev"
            , text " is a psychiatrist, working as a postdoctoral researcher at Aging Research Center, Karolinska Institute. He is currently involved in several projects at the Brain Lab (Hjärnlabbet) utilizing methods of multimodal imaging to study plastic brain changes associated with cognitive training. His research interests span neurodynamics underlying higher cognitive functions, creativity, adult development, as well as altered states of consciousness, psychosis and depersonalization phenomena. Alexander is a collaborator of the Imperial Research Group, analyzing brain imaging data from ongoing clinical trials with psychedelics."
            ]
        )
    , Speaker
        "David Nichols, PhD"
        (getImageUrl "david-nichols.jpg")
        (paragraph
            [ text "Prior to his retirement, "
            , bold "David Nichols"
            , text " was the Robert C. and Charlotte P. Anderson Distinguished Chair in Pharmacology and also a Distinguished Professor of Medicinal Chemistry and Molecular Pharmacology at the Purdue College of Pharmacy. He is currently an Adjunct Professor in the Eshelman School of Pharmacy at the University of North Carolina Chapel Hill, NC, where he continues research. During his years of research, Nichols appeared as an author of more than 300 scientific publications. Believing that psychedelic drugs could have positive therapeutic results, Nichols initiated the founding of the Heffter Research Institute in 1993 to support high-quality basic and clinical psychedelic research. Nichols also is known for coining the term ‘entactogen’ to differentiate the effects of MDMA and related chemicals from the phenethylamine hallucinogens. In addition to developing novel psychoactive substances in his lab at Purdue, the Nichols’ lab also synthesized high-purity MDMA, DMT, psilocybin, and other substances for research programs at other institutions. It became apparent to him that even if researchers could obtain the necessary approvals for their studies, there was no source for the pure drugs they required for human studies. Therefore, he made the DMT for Rick Strassman’s groundbreaking DMT study, published in 1994. The MDMA from his laboratory was used for most of the preclinical and all of the clinical studies employing MDMA from about 1986 until 2016, including Phase 2 clinical studies for the use of MDMA for treating post-traumatic stress disorder (PTSD.) Psilocybin made in his laboratory was used for Roland Griffith’s study of the effects of psilocybin in normal subjects, published in 2006, as well as for the Phase 2 clinical study of psilocybin-assisted treatment of distress in patients with a life-threatening diagnosis, published in 2016."
            ]
        )
    , Speaker
        "Elizabeth Nielson, PhD"
        (getImageUrl "elizabeth-nielson.jpg")
        (paragraph
            [ bold "Dr. Nielson"
            , text " is a therapist on the trials of psilocybin-assisted treatment of alcohol use disorder and of MDMA-assisted treatment of PTSD at NYU School of Medicine. Dr. Nielson's research includes qualitative studies of patient experiences in psychedelic-assisted therapy, interview studies of psychedelic therapists, and research on the historical use of LSD in psychotherapist training. Dr. Nielson is a psychologist in private practice at the Psychedelic Education and Continuing Care program at the Center for Optimal Living where she provides harm reduction and integration psychotherapy for people who use or have used psychedelics. Dr. Nielson studied art, psychology, and evidence-based interventions for drug and alcohol use, including harm reduction, motivational interviewing, community reinforcement, and mindfulness-based therapy. She held a post-doctoral fellowship in psychodynamic therapy at Adelphi University and a NIDA funded post-doctoral fellowship in the Behavioral Science Training Program in Drug Abuse Research at NDRI/NYU School of Nursing."
            ]
        )
    , Speaker
        "Tomas Palenicek, MD PhD"
        (getImageUrl "tomas-palenicek.jpg")
        (paragraph
            [ bold "Tomas Palenicek, M.D., Ph.D."
            , text ", has spent the last 15 years researching MDMA, LSD, mescaline, 2C-B, ketamine and cannabis. Tomas was trained in psychiatry and clinical electrophysiology, running human trials with ketamine as a model psychosis and in the treatment of depression. He is principal investigator of the first project in the Czech Republic intended to study the acute effects of cannabis in healthy volunteers. Furthermore, he is also principal investigator of the first human clinical trial in the Czech Republic studying the effects of psilocybin on brain dynamics and perception. Currently his research interests are oriented towards the area of EEG functional connectivity. He continues his clinical practice as a psychiatrist in local outpatient clinic."
            ]
        )
    , Speaker
        "Torsten Passie MD, PhD"
        (getImageUrl "torsten-passie.jpg")
        (paragraph
            [ bold "Torsten Passie M.D., Ph.D."
            , text ", is Professor of Psychiatry and Psychotherapy at Hannover Medical School (Germany) and currently Visiting Scientist at Goethe University in Frankfurt/Main (Germany). He studied philosophy, sociology (MA) at Leibniz-University, Hannover and medicine at Hannover Medical School. He worked at the Psychiatric University Clinic in Zürich (Switzerland) and with Professor Hanscarl Leuner (Göttingen), the leading European authority on hallucinogenic drugs. From 1998 to 2010 he was a scientist and psychiatrist at Hannover Medical school (Germany) where he researched the addictions and the psychophysiology of altered states of consciousness and their healing potential, including clinical research with hallucinogenic drugs (cannabis, ketamine, nitrous oxide, psilocybin). In 2012-2015 he was Visiting Professor at Harvard Medical School (Boston, USA)."
            ]
        )
    , Speaker
        "Jordi Riba, PhD"
        (getImageUrl "jordi-riba.jpg")
        (paragraph
            [ bold "Jordi Riba, Ph.D.,"
            , text " received his doctorate in pharmacology in 2003 at the Autonomous University of Barcelona (UAB), with a thesis on the human pharmacology of ayahuasca. He is associate professor of pharmacology at the UAB and also leads the Human Neuropsychopharmacology Research Group at the Sant Pau Hospital in Barcelona. He has published nearly forty journal articles and book chapters on the subject, and collaborated in the first clinical studies involving ayahuasca administration to patients with depression. Currently, Riba is studying the post-acute psychedelic “after-glow” and the use of ayahuasca in the treatment of various psychiatric conditions. He is also investigating the neuroprotective and neurogenic potential of ayahuasca alkaloids."
            ]
        )
    , Speaker
        "Stephen Ross, MD"
        (getImageUrl "stephen-ross.jpg")
        (paragraph
            [ bold "Stephen Ross, M.D."
            , text ", is Associate Professor of Psychiatry and Child & Adolescent Psychiatry at New York University School of Medicine and Associate Professor of Oral and Maxillofacial Pathology, Radiology, and Medicine at the NYU College of Dentistry. He directs the Division of Alcoholism and Drug Abuse and the Opioid Overdose Prevention Program at Bellevue Hospital Center in New York City. He is Director of Addiction Psychiatry at NYU Tisch Hospital and Director of the NYU Addiction Psychiatry Fellowship. He is certified in General and Addiction Psychiatry by the American Board of Psychiatry and Neurology (ABPN) and in Addiction Medicine by the American Society of Addiction Medicine (ASAM). Dr. Ross has received a dozen local and national teaching awards related to education of medical students, psychiatry residents, and post-graduate fellows. Dr. Ross is an expert on the therapeutic application of serotonergic hallucinogens to treat psychiatric and addictive spectrum illnesses. He directs the NYU Psychedelic Research Group and is Principal Investigator of the NYU Psilocybin Cancer Project."
            ]
        )
    , Speaker
        "Ben Sessa, MD"
        (getImageUrl "ben-sessa.jpg")
        (paragraph
            [ bold "Dr. Ben Sessa"
            , text " is a child and adolescent psychiatrist with 20 years clinical experience. Having worked initially with abused and maltreated children he has observed the sad and inevitable trajectory from childhood trauma into mental disorder and, particularly, addictions. His frustration at the lack of clinical efficacy apparent with traditional psychiatric treatments - and especially the rise of ineffective and potentially toxic  polypharmacy - has brought him to the door of psychedelics, and especially MDMA, as psychiatry’s best new potential approach to tackling his stuck and deserving patients. Dr. Sessa is currently running the world’s first clinical study exploring MDMA Therapy as a treatment for adult alcohol addiction. Dr. Sessa has published several text books on Psychedelic medicine, including ‘The Psychedelic Renaissance’ (2012/2017) and the novel, ‘To Fathom Hell and Soar Angelic’. Dr. Sessa is also outspoken on the subject of drug policy reform and the issues whereby government policies are impairing medical research, maintaining stigma and withholding potentially useful medical interventions from worthy patients."
            ]
        )
    , Speaker
        "Fredrik von Kieseritzky, PhD"
        (getImageUrl "fredrik-von-kieseritzky.jpg")
        (paragraph
            [ bold "Fredrik von Kieseritzky, Ph.D."
            , text " , received his doctorate in organic chemistry at the Royal Institute of Technology (KTH) in 2004. Since then, Fredrik has worked as an industrial scientist in the field of medicinal chemistry in large and small pharmaceutical companies. His main research areas are neurodegenerative diseases and pain disorders. He is the co-inventor of investigational drug Lanabecestat, currently in one of the world's most comprehensive Phase III clinical trials against Alzheimer's disease. In Sweden, Fredrik has assisted several physicians in getting standardized herbal cannabis approved against treatment-resistant neuropathic pain for a select few patients. Currently, he is involved in designing and carrying out a larger Phase II/III randomized and placebo-controlled clinical trial on cannabis (n = 100). As principal investigator, Fredrik is the co-inventor on several patent and patent applications and is the corresponding author on several peer-reviewed articles on organic synthesis and drug discovery. Fredrik is scientific advisor for a number of organizations, board member and vice-chairman for the Spinalis Foundation, and CEO of a small CRO, Arubedo AB."
            ]
        )
    , Speaker
        "Anne Wagner, PhD, CPsych"
        (getImageUrl "anne-wagner.jpg")
        (paragraph
            [ bold "Anne C. Wagner, Ph.D., C.Psych."
            , text ", is a Clinical Psychologist and Canadian Institutes of Health Research funded Postdoctoral Fellow at Ryerson University, working with Dr. Candice Monson. With Candice, Michael Mithoefer and Annie Mithoefer, Anne is investigating the combination of Cognitive Behavioral Conjoint Therapy for PTSD and MDMA. As well as being a trialist, Anne does work in Trauma-Informed Care and with the lived experiences of people living with HIV and in LGBTQ communities. She is a trainer for Cognitive Behavioral Conjoint Therapy for PTSD and a consultant for Cognitive Processing Therapy."
            ]
        )
    , Speaker
        "Rosalind Watts, DClinPsy"
        (getImageUrl "rosalind-watts.jpg")
        (paragraph
            [ bold "Rosalind Watts, DClinPsy,"
            , text " completed her clinical psychology training in London, and after six years of practicing psychotherapy she joined the Imperial College Psilocybin for Depression Study as a therapist guide. Ros believes that psychedelic treatments can have an important role in changing the way we conceptualise and treat mental health difficulties. Her research includes qualitative analysis of the therapeutic impact of psilocybin and LSD, which has informed her interest in ‘connection to self, others, and world’ as a mechanism of change. Her findings suggest that psilocybin treatment for depression may work via paradigmatically novel means compared to both antidepressant medication and some short-term talking therapies. She is currently working alongside Dr. Robin Carhart-Harris, Professor David Nutt and Dr. David Erritzoe planning the upcoming Imperial psilocybin for depression trial."
            ]
        )
    ]
