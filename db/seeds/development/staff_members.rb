StaffMember.create!(
    email: 'taro@example.com',
    family_name: '山田',
    given_name: '太郎',
    family_name_kana: 'ヤマダ',
    given_name_kana: 'タロウ',
    password: 'password',
    start_date: Date.today
)

StaffMember.create!(
    email: 'keiko@example.com',
    family_name: '山田',
    given_name: 'けいこ',
    family_name_kana: 'ヤマダ',
    given_name_kana: 'ケイコ',
    password: 'password',
    start_date: Date.today,
    suspended: true,
)
