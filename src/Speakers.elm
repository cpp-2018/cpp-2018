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
    "/docs/assets/speakers/" ++ fileName



---- SPEAKERS ----


speakers : List Speaker
speakers =
    [ Speaker
        "Jordi Riba, PhD"
        (getImageUrl "jordi-riba.jpg")
        (paragraph
            [ bold "Jordi Riba, Ph.D.,"
            , text " received his doctorate in pharmacology in 2003 at the Autonomous University of Barcelona (UAB), with a thesis on the human pharmacology of ayahuasca. He is associate professor of pharmacology at the UAB and also leads the Human Neuropsychopharmacology Research Group at the Sant Pau Hospital in Barcelona. He has published nearly forty journal articles and book chapters on the subject, and collaborated in the first clinical studies involving ayahuasca administration to patients with depression. Currently, Riba is studying the post-acute psychedelic “after-glow” and the use of ayahuasca in the treatment of various psychiatric conditions. He is also investigating the neuroprotective and neurogenic potential of ayahuasca alkaloids."
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
        "Charles Grob, MD"
        (getImageUrl "charles-grob.jpg")
        (paragraph
            [ bold "Charles S. Grob, M.D.,"
            , text " is Director of the Division of Child and Adolescent Psychiatry at Harbor-UCLA Medical Center, and Professor of Psychiatry and Pediatrics at the UCLA School of Medicine. Dr. Grob conducted the first government approved psychobiological research study of MDMA, and was the principal investigator of an international research project in the Brazilian Amazon studying the psychedelic plant brew, ayahuasca. He has also completed and published the first approved research investigation in several decades on the safety and efficacy of psilocybin treatment in terminal cancer patients with anxiety. Together with Alicia Danforth, he recently completed a pilot investigation into the use of an MDMA treatment model for social anxiety in autistic adults. Dr. Grob is the editor of Hallucinogens: A Reader (Tarcher/Putnam, 2002) and co-editor (with Roger Walsh) of Higher Wisdom: Eminent Elders Explore the Continuing Impact of Psychedelics (SUNY Press, 2005). He is also a founding board member of the Heffter Research Institute."
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
    , Speaker
        "Alexander Lebedev, MD PhD"
        (getImageUrl "alexander-lebedev.jpg")
        (paragraph
            [ bold "Alexander V. Lebedev"
            , text " is a psychiatrist, working as a postdoctoral researcher at Aging Research Center, Karolinska Institute. He is currently involved in several projects at the Brain Lab (Hjärnlabbet) utilizing methods of multimodal imaging to study plastic brain changes associated with cognitive training. His research interests span neurodynamics underlying higher cognitive functions, creativity, adult development, as well as altered states of consciousness, psychosis and depersonalization phenomena. Alexander is a collaborator of the Imperial Research Group, analyzing brain imaging data from ongoing clinical trials with psychedelics."
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
        "Alex Belser, PhD"
        (getImageUrl "alex-belser.jpg")
        (paragraph
            [ bold "Alexander Belser, Ph.D. Candidate, M.Phil.,"
            , text " is a Clinical Research Fellow at Yale University.  Alex was a founding member of the Psychedelic Research Group at New York University (NYU) in 2006.  There he conducted a qualitative study exploring how cancer patients experience psilocybin-assisted psychotherapy.  Alex serves as a scientific collaborator for a qualitative study investigating psilocybin-assisted psychotherapy as a treatment for alcohol addiction. He is also interviewing religious leaders who are administered psilocybin.  Alex has published a number of peer-reviewed articles and book chapters, and serves as a peer reviewer for the Journal of Psychopharmacology. Alex graduated from Georgetown University, and pursued graduate studies at Cambridge University, NYU, and Columbia University.  As a clinician, Alex treats patients with trauma in a multi-site trial of MDMA-assisted psychotherapy as a treatment for post-traumatic stress disorder (PTSD), which was recently designated a “breakthrough therapy” by the Food and Drug Administration (FDA).  Alex completed his clinical and research training in psychology at Bellevue Hospital, New York Psychiatric Institute at Columbia University Medical Center, and Mount Sinai Beth Israel Hospital."
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
        "Elizabeth Nielson, PhD"
        (getImageUrl "elizabeth-nielson.jpg")
        (paragraph
            [ bold "Dr. Nielson"
            , text " is a therapist on the trials of psilocybin-assisted treatment of alcohol use disorder and of MDMA-assisted treatment of PTSD at NYU School of Medicine. Dr. Nielson's research includes qualitative studies of patient experiences in psychedelic-assisted therapy, interview studies of psychedelic therapists, and research on the historical use of LSD in psychotherapist training. Dr. Nielson is a psychologist in private practice at the Psychedelic Education and Continuing Care program at the Center for Optimal Living where she provides harm reduction and integration psychotherapy for people who use or have used psychedelics. Dr. Nielson studied art, psychology, and evidence-based interventions for drug and alcohol use, including harm reduction, motivational interviewing, community reinforcement, and mindfulness-based therapy. She held a post-doctoral fellowship in psychodynamic therapy at Adelphi University and a NIDA funded post-doctoral fellowship in the Behavioral Science Training Program in Drug Abuse Research at NDRI/NYU School of Nursing."
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
    ]
